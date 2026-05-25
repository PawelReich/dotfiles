local M = {}

function M.send(name)
    hl.dispatch(hl.dsp.window.move({ workspace = "special:" .. name }))
end

function M.toggle(name)
    hl.dispatch(hl.dsp.workspace.toggle_special(name))
end

function M.setup(name, key, mod)
    mod = mod or "SUPER"
    hl.bind(mod .. " + " .. key, function() M.toggle(name) end)
    hl.bind(mod .. " + SHIFT + " .. key, function() M.send(name) end)
end

function M.get(name)
    local current = hl.get_active_workspace()
    if not current then return end
    local wins = hl.get_windows({ workspace = "special:" .. name })
    if #wins == 0 then return end
    local win = wins[#wins]
    hl.dispatch(hl.dsp.window.move({ workspace = current.name .. ",address:" .. win.address }))
    hl.dispatch(hl.dsp.focus({ address = win.address }))
end

return M
