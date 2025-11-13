vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.showtabline = 2
vim.o.smartindent = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.splitright = true

vim.g.mapleader = " "

-- packages via native package manager
vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" }, -- telescope dependency
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim", },
	{ src =  "https://github.com/folke/todo-comments.nvim", dependencies = { 'nvim-lua/plenary.nvim' }, opts = {} }, -- Highlight todo, notes, etc in comments
})


require('typst-preview').setup({})

-- 1. Set up mason (must come before mason-lspconfig)
require('mason').setup()

-- 2. Set up mason-lspconfig and auto-install servers
local lspconfig = require('lspconfig')
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		'clangd',
		'pyright',
		'tinymist',
		--'rust_analyzer',
		-- add more servers here
	},
	automatic_installation = true, -- ensures missing servers are installed automatically

	function(server_name)
		lspconfig[server_name].setup({})
	end,
})

vim.lsp.config["tinymist"] = {
	cmd = { "tinymist" },
	filetypes = { "typst" },
	settings = {
		formatterMode = 'typstyle',
		exportPdf = 'onSave',
		semanticTokens = 'disable',
	}
}

require('telescope').setup({})
local builtin = require("telescope.builtin")

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.keymap.set('n', "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', "<leader>fo", builtin.oldfiles, { desc = "Telescope recently opened files" })
vim.keymap.set('n', "<leader>gs", builtin.grep_string, { desc = "Telescope grep string" })
vim.keymap.set('n', "gd", builtin.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set('n', "<leader><leader>", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', "<leader>e", "<cmd>Ex<CR>", { desc = "Explorer" })
vim.keymap.set('n', '<leader>ts', '<cmd>setlocal spell spelllang=en_gb<cr>', { desc = '[T]oggle [S]pellcheck (en-us)' })
vim.keymap.set('n', '<leader>sw', '<cmd>set wrap<cr>', { desc = 'Set wrap' })
vim.keymap.set('n', '<leader>snw', '<cmd>set nowrap<cr>', { desc = 'Set nowrap' })
vim.keymap.set('n', '<leader>se', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Show error"})
vim.keymap.set({'n', 'i'}, "<leader>wq", "<cmd>wq<cr>", { desc = "[W]rite and [Q]uit" })
vim.keymap.set({'n', 'i'}, "<leader>w", "<cmd>w<cr>", { desc = "[W]rite" })
-- terminal keymaps
vim.keymap.set({'n', 'i'}, "<leader>ot", "<cmd>hor te<cr>", { desc = "[O]pen [T]erminal" })
vim.keymap.set({'t', 'n'}, "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit Terminal" })

-- theme
--require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")

-- transparent statusbar
vim.cmd(":hi statusline guibg=NONE")
