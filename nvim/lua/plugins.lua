return {
    {
        'ribru17/bamboo.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('bamboo').setup {
                -- optional configuration here
            }
            require('bamboo').load()
        end,
    },
    {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    },
    {'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"tpope/vim-fugitive"},
    {"mfussenegger/nvim-dap"},
    {'hiphish/rainbow-delimiters.nvim'},
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        }
    },
    {
        'smoka7/hop.nvim',
        version = "*",
        opts = {
            keys = 'etovxqpdygfblzhckisuran'
        }
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'stevearc/conform.nvim',
        opts = {},
    },
    { 'f-person/git-blame.nvim' },
    { 'sindrets/diffview.nvim' },
    { 'ThePrimeagen/harpoon' }
}

