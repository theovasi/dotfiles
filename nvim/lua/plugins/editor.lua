return {
    {
        "nvim-lua/plenary.nvim",
        opts = {},
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        "BurntSushi/ripgrep",
        opts = {},
        config = function() end,
    },
	{'williamboman/mason.nvim'},
    {
		"nvim-tree/nvim-tree.lua",
        opts = {},
        config = function() end,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
            on_attach = function ()
                local api = require "nvim-tree.api"

                local function opts(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- default mappings
                api.config.mappings.default_on_attach(bufnr)

                -- custom mappings
                vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
                vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
		end
	},
	{
	  "echasnovski/mini.pairs",
	  event = "VeryLazy",
	  opts = {
		modes = { insert = true, command = true, terminal = false },
		-- skip autopair when next character is one of these
		skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
		-- skip autopair when the cursor is inside these treesitter nodes
		skip_ts = { "string" },
		-- skip autopair when next character is closing pair
		-- and there are more closing pairs than opening pairs
		skip_unbalanced = true,
		-- better deal with markdown code blocks
		markdown = true,
	  },
	},
	{
	  "stevearc/conform.nvim",
	  dependencies = { "mason.nvim" },
	  lazy = true,
	  cmd = "ConformInfo",
	  keys = {
		{
		  "<leader>cF",
		  function()
			require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
		  end,
		  mode = { "n", "v" },
		  desc = "Format Injected Langs",
		},
	  },
	  opts = function()
		local plugin = require("lazy.core.config").plugins["conform.nvim"]
		---@type conform.setupOpts
		local opts = {
		  default_format_opts = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
			lsp_format = "fallback", -- not recommended to change
		  },
		  formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			sh = { "shfmt" },
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
		  },
		  -- The options you set here will be merged with the builtin formatters.
		  -- You can also define any custom formatters here.
		  ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
		  formatters = {
			injected = { options = { ignore_errors = true } },
			-- # Example of using dprint only when a dprint.json file is present
			-- dprint = {
			--   condition = function(ctx)
			--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
			--   end,
			-- },
			--
			-- # Example of using shfmt with extra args
			-- shfmt = {
			--   prepend_args = { "-i", "2", "-ci" },
			-- },
		  },
		}
		return opts
	  end,
	  config = function()
	  end,
	}
}
