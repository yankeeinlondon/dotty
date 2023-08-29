-- install packer
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "=================================="
    print "    Plugins are being installed"
    print "    Wait until Packer completes,"
    print "       then restart nvim"
    print "=================================="
    vim.cmd [[ packadd packer.nvim ]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- get local ref to packer
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify "Failure to load 'packer'!"
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- install plugins
require("packer").startup(function(use)
    -- Package manager
    use "wbthomason/packer.nvim"

    -- Visual Flurishes
    use "navarasu/onedark.nvim" -- Theme inspired by Atom
    use "folke/tokyonight.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "yamatsum/nvim-cursorline"
    use "goolord/alpha-nvim"
    use "karb94/neoscroll.nvim"

    -- pretty status line
    use { "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" }

    -- Linters and Formatters
    use "jose-elias-alvarez/null-ls.nvim"

    -- Notifications
    use "rcarriga/nvim-notify"

    -- fancy explorer
    use { "nvim-tree/nvim-tree.lua", requires = "nvim-tree/nvim-web-devicons" }

    -- keyboard
    use "folke/which-key.nvim"

    -- toggleterm
    use "akinsho/toggleterm.nvim"

    -- symbol explorer
    use "simrat39/symbols-outline.nvim"

    -- actions
    use {
        "RishabhRD/lspactions",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-lua/popup.nvim",
        },
    }
    -- projects
    use "ahmedkhalf/project.nvim"

    use {
        "jamestthompson3/sort-import.nvim",
        config = function()
            require("sort-import").setup()
        end,
    }

    -- debugging
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"
    use "theHamsta/nvim-dap-virtual-text"
    use "nvim-telescope/telescope-dap.nvim"

    -- LSP Configuration & Plugins
    use {
        "neovim/nvim-lspconfig",
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",

            -- Useful status updates for LSP
            "j-hui/fidget.nvim",

            -- Additional lua configuration, makes nvim stuff amazing
            "folke/neodev.nvim",
        },
    }

    use "simrat39/rust-tools.nvim" -- [repo](https://github.com/simrat39/rust-tools.nvim)

    -- Autocompletion / CMP
    use {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        requires = { "nvim-lua/plenary.nvim" },
    }

    use "epwalsh/obsidian.nvim"

    use { -- Autocompletion
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saecki/crates.nvim",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            require "user.cmp"
        end,
    }

    use "nvim-treesitter/nvim-treesitter"
    use { -- Additional text objects via treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
        after = "nvim-treesitter",
    }

    -- text manipulation
    use "kylechui/nvim-surround"

    -- Git related plugins
    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"
    use "lewis6991/gitsigns.nvim"

    -- themes
    use "lukas-reineke/indent-blankline.nvim" -- Add indentation guides even on blank lines
    use "numToStr/Comment.nvim" -- "gc" to comment visual regions/lines
    use "tpope/vim-sleuth" -- Detect tabstop and shiftwidth automatically
    use "nvim-lua/plenary.nvim"

    -- Fuzzy Finder (files, lsp, etc)
    use { "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } }

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }

    -- Add custom plugins to packer from ~/.config/nvim/lua/custom/plugins.lua
    local has_plugins, plugins = pcall(require, "custom.plugins")
    if has_plugins then
        plugins(use)
    end

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
