require("config.lazy")
require("config.cmp")
require("config.lsp-zero")
require("config.treesitter")
require("config.fugitive")
require("config.dap")
require("config.neotree")
require("config.hop")
require("config.telescope")
require("config.conform")
require("config.git-blame")
require("config.diffview")

require("config.set")
require("config.remap")

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
