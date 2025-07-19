return {
	"williamboman/mason.nvim",
	version = "^1.0.0",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"html",
				"jsonls",
				"ruff",
				"pyright",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"prettier",
				"stylua", -- lua formatter
				"pyright",
				"ruff", -- python lint, formater, lsp
			},
		})
	end,
}
