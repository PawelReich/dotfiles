#!/usr/bin/env python 
# https://github.com/Sebastiaan76/waybar_wireplumber_audio_changer/blob/main/audio_changer.py
import subprocess

def parse_wpctl_status():
    output = str(subprocess.check_output("wpctl status", shell=True, encoding='utf-8'))

    lines = output.replace("├", "").replace("─", "").replace("│", "").replace("└", "").splitlines()

    sinks_index = None
    for index, line in enumerate(lines):
        if "Sinks:" in line:
            sinks_index = index
            break

    # start by getting the lines after "Sinks:" and before the next blank line and store them in a list
    sinks = []
    for line in lines[sinks_index +1:]:
        if not line.strip():
            break
        sinks.append(line.strip())

    # remove the "[vol:" from the end of the sink name
    for index, sink in enumerate(sinks):
        sinks[index] = sink.split("[vol:")[0].strip()
    
    # strip the * from the default sink and instead append "- Default" to the end. Looks neater in the wofi list this way.
    for index, sink in enumerate(sinks):
        if sink.startswith("*"):
            sinks[index] = sink.strip().replace("*", "").strip()

    # make the dictionary in this format {'sink_id': <int>, 'sink_name': <str>}
    sinks_dict = [{"sink_id": int(sink.split(".")[0]), "sink_name": sink.split(".")[1].strip()} for sink in sinks]

    return sinks_dict

output = ''
sinks = parse_wpctl_status()
for items in sinks:
    output += f"{items['sink_name']}\n"

# Call wofi and show the list. take the selected sink name and set it as the default sink
wofi_command = f"echo '{output}' | tofi --prompt-text='Select sink:'"

wofi_process = subprocess.run(wofi_command, shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)

selected_sink_name = wofi_process.stdout.strip()
if selected_sink_name == "":
    print("Cancelled")
    exit(0)
sinks = parse_wpctl_status()
selected_sink = next(sink for sink in sinks if sink['sink_name'] == selected_sink_name)
subprocess.run(f"wpctl set-default {selected_sink['sink_id']}", shell=True)
