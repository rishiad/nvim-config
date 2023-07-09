return { "L3MON4D3/LuaSnip", 
  dependencies = {
    -- Put snippet sources here
		  "iurimateus/luasnip-latex-snippets.nvim", -- Math LaTeX snippets
		  "rafamadriz/friendly-snippets" -- Collection of snippets
		  },
    config = function()
      local luasnip = require("luasnip")
      -- Snippet sources
      local tex_snippets = require("luasnip-latex-snippets")
    
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })
    
      luasnip.add_snippets("tex", tex_snippets.setup({ use_treesitter = true }))
    end
}
