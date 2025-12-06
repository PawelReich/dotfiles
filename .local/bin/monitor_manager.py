#!/usr/bin/env python 
import subprocess
from pathlib import Path

home = Path.home()

def drun(candidates : list[str], prompt : str):
    output = '\n'.join(candidates)
    command = f"echo '{output}' | tofi --prompt-text='{prompt}'"
    process = subprocess.run(command, shell=True, encoding='utf-8', stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    selected = process.stdout.strip()

    return selected

def disable_screen():
    print("Disable")
    config_monitors(False)

def enable_screen():
    print("Enable")
    config_monitors(True)

def mirror():
    print("Mirror")
    config_monitors(True, True)

def config_monitors(enable_internal : bool, mirror = False):
    config : list[str] = []
    catch_all = "monitor = , highres, auto, 1"
    if mirror:
        catch_all += ",mirror,eDP-1"
    config.append(catch_all)
    if not enable_internal:
        config.append("monitor = eDP-1, disabled")

    with open(home / '.config/hypr/hyprland-devices.conf', "w+") as f:
        f.write('\n'.join(config))

options = [
    ["Disable internal screen", disable_screen], 
    ["Enable internal screen", enable_screen],
    ["Mirror", mirror],
]

candidates = map(lambda x: x[0], options)
selected = drun(candidates, "Select monitor settings:")
if selected == "":
    print("Cancelled")
    exit(0)

selected_option = next(f for f in options if f[0] == selected)
selected_option[1]()

