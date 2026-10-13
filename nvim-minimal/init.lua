require("config.lazy")
require("config.neotree")
require("config.hop")

require("config.set")
require("config.remap")

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
