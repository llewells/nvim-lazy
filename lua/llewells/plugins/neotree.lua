vim.cmd([[
    highlight! link NeoTreeDirectoryIcon NvimTreeFolderIcon
    highlight! link NeoTreeDirectoryName NvimTreeFolderName
    highlight! link NeoTreeSymbolicLinkTarget NvimTreeSymlink
    highlight! link NeoTreeRootName NvimTreeRootFolder
    highlight! link NeoTreeDirectoryName NvimTreeOpenedFolderName
    highlight! link NeoTreeFileNameOpened NvimTreeOpenedFile
]])

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			filesystem = {
				components = {
					harpoon_index = function(config, node, _)
						local Marked = require("harpoon.mark")
						local path = node:get_id()
						local success, index = pcall(Marked.get_index_of, path)
						if success and index and index > 0 then
							return {
								text = string.format("%d ", index), -- <-- Add your favorite harpoon like arrow here
								highlight = config.highlight or "NeoTreeDirectoryIcon",
							}
						else
							return {
								text = "  ",
							}
						end
					end,
				},
				renderers = {
					file = {
						{ "icon" },
						{ "name", use_git_status_colors = true },
						{ "harpoon_index" }, --> This is what actually adds the component in where you want it
						{ "diagnostics" },
						{ "git_status", highlight = "NeoTreeDimText" },
					},
				},
			},
			window = {
				popup = {
					position = { col = "100%", row = "2" },
					size = function(state)
						local root_name = vim.fn.fnamemodify(state.path, ":~")
						local root_len = string.len(root_name) + 4
						return {
							width = math.max(root_len, 50),
							height = vim.o.lines - 6,
						}
					end,
				},
			},
		})
	end,
}
