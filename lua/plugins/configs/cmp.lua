return { "hrsh7th/nvim-cmp", 
dependencies = {	
          "hrsh7th/cmp-nvim-lsp", -- LSP source 
					"saadparwaiz1/cmp_luasnip", -- Snippets source 
					"hrsh7th/cmp-buffer", -- Buffer source
					"onsails/lspkind-nvim", -- LSP icons
					"hrsh7th/cmp-nvim-lua", -- nvim lua api source
				  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    require("luasnip/loaders/from_vscode").lazy_load()

 	local has_words_before = function()
		unpack = unpack or table.unpack
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end   
    cmp.setup({
      preselect = cmp.PreselectMode.Item,
			-- completion = { autocomplete = false }, -- Make completion only on demand
			enabled = function()
				local in_prompt = vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
				if in_prompt then
					return false
				end
				local context = require("cmp.config.context")
				return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
			end,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

      mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),

				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),

				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-q>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({
					select = true,
				}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "buffer", keyword_length = 5 },
      },
      snippet = {
        expand = function (args)
          luasnip.lsp_expand(args.body)
        end	
      },
      formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Nvim]",
          })
        })
      }
    })
  end
}
