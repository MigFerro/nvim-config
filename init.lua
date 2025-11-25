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

--------------------------------------------------------------------------------------------
-- Theme and appearance
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" }
})

--require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")

-- transparent statusbar
vim.cmd(":hi statusline guibg=NONE")


--------------------------------------------------------------------------------------------
-- Mason
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" }
})

-- 1. Set up mason (must come before mason-lspconfig)
require('mason').setup()

-- 2. Set up mason-lspconfig and auto-install servers
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		'clangd',
		'pyright',
		'tinymist',
		'emmet_ls',
		--'rust_analyzer',
		-- add more servers here
	},
	automatic_installation = true, -- ensures missing servers are installed automatically

	function(server_name)
		vim.lsp.config[server_name].setup({
		})
	end,
})


--------------------------------------------------------------------------------------------
-- Telescope
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" }
})

vim.pack.add({
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = vim.version.range("0.1.9") }
})

require('telescope').setup({})
local builtin = require("telescope.builtin")


--------------------------------------------------------------------------------------------
-- Treesitter
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = 'master' }
})

require('nvim-treesitter.configs').setup({})


--------------------------------------------------------------------------------------------
-- Typst
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/chomosuke/typst-preview.nvim", }
})

require('typst-preview').setup({})


--------------------------------------------------------------------------------------------
-- Snippets
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/rafamadriz/friendly-snippets", }
})



--------------------------------------------------------------------------------------------
-- Autocompletion (blink)
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('1') },
	'https://github.com/rafamadriz/friendly-snippets'
})

require('blink.cmp').setup({
	keymap = { preset = 'default' },
	sources = {
        -- add lazydev to your completion providers
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = 'mono',
	},
	completion = { documentation = { auto_show = true } },
	signature = { enabled = true },
	fuzzy = { implementation = 'lua' }
})


--------------------------------------------------------------------------------------------
-- LSP configuration
--------------------------------------------------------------------------------------------

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" }
})

-- capabilities

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))

capabilities = vim.tbl_deep_extend('force', capabilities, {
	textDocument = {
		foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true
		}
	}
})

-- for all LSPs

vim.lsp.config('*', {
	dependencies = {
		'saghen/blink.cmp',
	},
	capabilities = capabilities,
	root_markers = { '.git' },
})

--lazydev
vim.pack.add({
	{ src = "https://github.com/folke/lazydev.nvim" }
})

require('lazydev').setup({
	ft = 'lua',
})


--------------------------------------------------------------------------------------------
-- Quirks
--------------------------------------------------------------------------------------------

-- Highlight todo, notes, etc in comments
vim.pack.add({
	{ src = "https://github.com/folke/todo-comments.nvim" },
	'https://github.com/nvim-lua/plenary.nvim'
})

require('todo-comments').setup({})


--------------------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------------------

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
vim.keymap.set('n', '<leader>se', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Show error" })
vim.keymap.set({ 'n' }, "<leader>wq", "<cmd>wq<cr>", { desc = "[W]rite and [Q]uit" })
vim.keymap.set({ 'n' }, "<leader>w", "<cmd>w<cr>", { desc = "[W]rite" })
-- terminal keymaps
vim.keymap.set({ 'n' }, "<leader>ot", "<cmd>hor te<cr>", { desc = "[O]pen [T]erminal" })
vim.keymap.set({ 't', 'n' }, "<leader>q", "<cmd>q<cr>", { desc = "[Q]uit Terminal" })

