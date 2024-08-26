return {
	{ 
		"xiantang/darcula-dark.nvim", 
		init = function()
			vim.cmd("colorscheme darcula-dark")
		end
	},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'github/copilot.vim'},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"tpope/vim-fugitive"},
    {"mfussenegger/nvim-dap"},
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {'hiphish/rainbow-delimiters.nvim'}
}

