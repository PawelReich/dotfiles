local function get_last_segment(path)
    local segments = {}
    for segment in string.gmatch(path, "[^/]+") do
        table.insert(segments, segment)
    end
    return segments[#segments]
end


return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		-- Custom Lualine component to show attached language server
		local clients_lsp = function()
			local bufnr = vim.api.nvim_get_current_buf()

			local clients = vim.lsp.get_clients()
			if next(clients) == nil then
				return ""
			end

            local c = {}
			for _, client in pairs(clients) do
				table.insert(c, client.name)
			end
			return " " .. table.concat(c, "|")
		end
    
        local current_sol = function()
            
            local sol = ""
            if not (vim.g.roslyn_nvim_selected_solution == nil or vim.g.roslyn_nvim_selected_solution == '') then
                sol = get_last_segment(vim.g.roslyn_nvim_selected_solution)
            end
            return sol
        end

        require("lualine").setup({
			sections = {
				lualine_a = {
					{ "mode" },
				},
				lualine_b = {
					{
						"filetype",
						icon_only = true,
						padding = { left = 1, right = 0 },
					},
					"filename",
                    {
                        "navic",
                        color_correction = "dynamic"
                    },
				},
				lualine_c = {
					{
						"branch"
					},

					{
						"diff",
						symbols = { added = " ", modified = " ", removed = " " },
						colored = false,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
						update_in_insert = true,
					},
				},
				lualine_y = { clients_lsp, current_sol },
				lualine_z = {
					{ "location" },
				},
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { "location" },
			},
			extensions = { "toggleterm", "trouble" },
		})
	end,
}
