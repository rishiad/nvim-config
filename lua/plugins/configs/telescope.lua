-- Search
return {
"nvim-telescope/telescope.nvim",
config = function()
  require("telescope").setup({
   file_ignore_patterns = { "node_modules/", ".git/", ".cache/", "target/" }, 
   color_devicons = true,
   defaults = {
    vimgrep_arguments = {
      "rg",
      "--with-filename",
      "--line-number",
    }
   },
   pickers = {
       find_files = {
           theme="dropdown"
       }
   },
   extensions = {
    file_browser = {
      theme = "ivy",
      hijack_netrw = true,
    }
   },
   
  })
end
}
