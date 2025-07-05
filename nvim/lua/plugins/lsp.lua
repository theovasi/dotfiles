return {
	{
	  "nvim-treesitter/nvim-treesitter",
	  opts = {
          ensure_installed = { "rust", "ron", "lua" },
          -- Install parsers synchronously (only applied to `ensure_installed`)
          sync_install = false,

          -- Automatically install missing parsers when entering buffer
          -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
          auto_install = true,

          -- List of parsers to ignore installing (or "all")
          ignore_install = { "javascript" },

          ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
          -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

          highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
          },
      },
	},
	{
	  "Saecki/crates.nvim",
	  event = { "BufRead Cargo.toml" },
	  opts = {
		completion = {
		  crates = {
			enabled = true,
		  },
		},
		lsp = {
		  enabled = true,
		  actions = true,
		  completion = true,
		  hover = true,
		},
	  },
	},
	{
	  "neovim/nvim-lspconfig",
	  opts = {
		servers = {
		  bacon_ls = {
			enabled = diagnostics == "bacon-ls",
		  },
		  rust_analyzer = { enabled = false },
		},
	  },
	  config = function()
	  end
	},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/cmp-path'},
	{'hrsh7th/cmp-cmdline'},
	{
	  "saghen/blink.cmp",
	  version = not vim.g.lazyvim_blink_main and "*",
	  build = vim.g.lazyvim_blink_main and "cargo build --release",
	  opts_extend = {
		"sources.completion.enabled_providers",
		"sources.compat",
		"sources.default",
	  },
	  dependencies = {
		"rafamadriz/friendly-snippets",
		-- add blink.compat to dependencies
		{
		  "saghen/blink.compat",
		  optional = true, -- make optional so it's only enabled if any extras need it
		  opts = {},
		  version = not vim.g.lazyvim_blink_main and "*",
		},
	  },
	  event = "InsertEnter",

	  ---@module 'blink.cmp'
	  ---@type blink.cmp.Config
	  opts = {
		snippets = {
		  expand = function(snippet, _)
			return cmp.expand(snippet)
		  end,
		},
		appearance = {
		  -- sets the fallback highlight groups to nvim-cmp's highlight groups
		  -- useful for when your theme doesn't support blink.cmp
		  -- will be removed in a future release, assuming themes add support
		  use_nvim_cmp_as_default = false,
		  -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		  -- adjusts spacing to ensure icons are aligned
		  nerd_font_variant = "mono",
		},
		completion = {
		  accept = {
			-- experimental auto-brackets support
			auto_brackets = {
			  enabled = true,
			},
		  },
		  menu = {
			draw = {
			  treesitter = { "lsp" },
			},
		  },
		  documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		  },
		  ghost_text = {
			enabled = vim.g.ai_cmp,
		  },
		},

		-- experimental signature help support
		-- signature = { enabled = true },

		sources = {
		  -- adding any nvim-cmp sources here will enable them
		  -- with blink.compat
		  compat = {},
		  default = { "lsp", "path", "snippets", "buffer" },
		},

		cmdline = {
		  enabled = false,
		},

		keymap = {
		  preset = "enter",
		  ["<C-y>"] = { "select_and_accept" },
		},
	  },
	  ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
	  config = function(_, opts)

		local cmp = require("cmp")
		-- setup compat sources
		local enabled = opts.sources.default
		for _, source in ipairs(opts.sources.compat or {}) do
		  opts.sources.providers[source] = vim.tbl_deep_extend(
			"force",
			{ name = source, module = "blink.compat.source" },
			opts.sources.providers[source] or {}
		  )
		  if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
			table.insert(enabled, source)
		  end
		end

		-- Unset custom prop to pass blink.cmp validation
		opts.sources.compat = nil

		-- check if we need to override symbol kinds
		for _, provider in pairs(opts.sources.providers or {}) do
		  ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
		  if provider.kind then
			local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
			local kind_idx = #CompletionItemKind + 1

			CompletionItemKind[kind_idx] = provider.kind
			---@diagnostic disable-next-line: no-unknown
			CompletionItemKind[provider.kind] = kind_idx

			---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
			local transform_items = provider.transform_items
			---@param ctx blink.cmp.Context
			---@param items blink.cmp.CompletionItem[]
			provider.transform_items = function(ctx, items)
			  items = transform_items and transform_items(ctx, items) or items
			  for _, item in ipairs(items) do
				item.kind = kind_idx or item.kind
				item.kind_icon = config.icons.kinds[item.kind_name] or item.kind_icon or nil
			  end
			  return items
			end

			-- Unset custom prop to pass blink.cmp validation
			provider.kind = nil
		  end
		end

		require("blink.cmp").setup(opts)
	  end,
	},
	{
	 "hrsh7th/nvim-cmp",
		 opts = function()
			local cmp = require("cmp")
			return {
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
			 mapping = {
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-n>'] = cmp.mapping.select_next_item(),
				-- Add tab support
				['<S-Tab>'] = cmp.mapping.select_prev_item(),
				['<Tab>'] = cmp.mapping.select_next_item(),
				['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-e>'] = cmp.mapping.close(),
				['<CR>'] = cmp.mapping.confirm({
				  behavior = cmp.ConfirmBehavior.Insert,
				  select = true,
				})
			  },
			  -- Installed sources:
			 sources = {
				{ name = 'path' },                              -- file paths
				{ name = 'nvim_lsp', keyword_length = 3 },      -- from language server
				{ name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
				{ name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
				{ name = 'buffer', keyword_length = 2 },        -- source current buffer
				{ name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
				{ name = 'calc'},                               -- source for math calculation
			  },
			 window = {
				  completion = cmp.config.window.bordered(),
				  documentation = cmp.config.window.bordered(),
			  },
			 formatting = {
				  fields = {'menu', 'abbr', 'kind'},
				  format = function(entry, item)
					  local menu_icon ={
						  nvim_lsp = 'λ',
						  vsnip = '⋗',
						  buffer = 'Ω',
						  path = '🖫',
					  }
					  item.menu = menu_icon[entry.source.name]
					  return item
				  end,
			  },
		  }
	  end
	},
	{'hrsh7th/cmp-vsnip'},
	{'hrsh7th/vim-vsnip'},
	{
	  "mrcjkb/rustaceanvim",
	  version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
	  ft = { "rust" },
	  opts = {
		server = {
		  on_attach = function(_, bufnr)
			vim.keymap.set("n", "<leader>cR", function()
			  vim.cmd.RustLsp("codeAction")
			end, { desc = "Code Action", buffer = bufnr })
			vim.keymap.set("n", "<leader>dr", function()
			  vim.cmd.RustLsp("debuggables")
			end, { desc = "Rust Debuggables", buffer = bufnr })
		  end,
		  default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
			  cargo = {
				allFeatures = true,
				loadOutDirsFromCheck = true,
				buildScripts = {
				  enable = true,
				},
			  },
			  -- Add clippy lints for Rust if using rust-analyzer
			  checkOnSave = diagnostics == "rust-analyzer",
			  -- Enable diagnostics if using rust-analyzer
			  diagnostics = {
				enable = diagnostics == "rust-analyzer",
			  },
			  procMacro = {
				enable = true,
				ignored = {
				  ["async-trait"] = { "async_trait" },
				  ["napi-derive"] = { "napi" },
				  ["async-recursion"] = { "async_recursion" },
				},
			  },
			  files = {
				excludeDirs = {
				  ".direnv",
				  ".git",
				  ".github",
				  ".gitlab",
				  "bin",
				  "node_modules",
				  "target",
				  "venv",
				  ".venv",
				},
			  },
			},
		  },
		},
	  },
	  config = function()
	  end,
	}
}
