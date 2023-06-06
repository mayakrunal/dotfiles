local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false
    -- packer.nvim configuration
    local conf = {
        profile = {
            enable = true,
            threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.nvim]]
        end
        vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    end

    local function plugins(use)
        use { "wbthomason/packer.nvim" }

        -- Load only when require
        use { "nvim-lua/plenary.nvim", module = "plenary" }

        use {
            'goolord/alpha-nvim',
            config = function()
                require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
            end
        }

        -- -- One dark theme
        -- use { 'navarasu/onedark.nvim',
        --     config = function()
        --         -- Lua
        --         require('onedark').setup {
        --             style = 'cool',      -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        --             transparent = false, -- Show/hide background
        --         }
        --         require('onedark').load()
        --     end
        -- }
        -- catppuccin theme
        use { "catppuccin/nvim", as = "catppuccin",
            config = function()
                require("catppuccin").setup({
                    flavour = "mocha", -- latte, frappe, macchiato, mocha
                    term_colors = false,
                    integrations = {
                        cmp = true,
                        gitsigns = true,
                        nvimtree = true,
                        leap = true,
                        mason = true,
                        which_key = true,
                        dap = {
                            enabled = true,
                            enable_ui = true, -- enable nvim-dap-ui
                        },
                        indent_blankline = {
                            enabled = true,
                            colored_indent_levels = false,
                        },
                        native_lsp = {
                            enabled = true,
                            virtual_text = {
                                errors = { "italic" },
                                hints = { "italic" },
                                warnings = { "italic" },
                                information = { "italic" },
                            },
                            underlines = {
                                errors = { "underline" },
                                hints = { "underline" },
                                warnings = { "underline" },
                                information = { "underline" },
                            },
                        },
                        vimwiki = true
                        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                    },
                })

                vim.cmd.colorscheme "catppuccin"
            end }

        -- vim-fugitive
        use { 'tpope/vim-fugitive', cmd = "Git" }


        -- which key
        use {
            "folke/which-key.nvim",
            event = "VimEnter",
            config = function()
                require("config.whichkey").setup()
            end
        }

        -- IndentLine
        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufReadPre",
            config = function()
                require("config.indentblankline").setup()
            end,
        }

        -- Better icons
        use {
            "nvim-tree/nvim-web-devicons",
            module = "nvim-web-devicons",
            config = function()
                require("nvim-web-devicons").setup { default = true }
            end,
        }

        -- Better Comment
        use {
            "numToStr/Comment.nvim",
            opt = true,
            keys = { "gc", "gcc", "gbc" },
            config = function()
                require("Comment").setup {}
            end,
        }
        -- Better Comment
        use {
            "ggandor/leap.nvim",
            config = function()
                require('leap').add_default_mappings()
            end,
        }

        -- Markdown
        use {
            "iamcco/markdown-preview.nvim",
            run = function()
                vim.fn["mkdp#util#install"]()
            end,
            ft = "markdown",
            cmd = { "MarkdownPreview" },
        }

        -- Status line
        use {
            "nvim-lualine/lualine.nvim",
            event = "VimEnter",
            config = function()
                require("config.lualine").setup()
            end,
            requires = { "nvim-web-devicons" },
        }
        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function()
                require("config.treesitter").setup()
            end,
        }

        -- Treesitter textobjects
        use({
            "nvim-treesitter/nvim-treesitter-textobjects",
            after = "nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter",
        })

        use { 'ibhagwan/fzf-lua',
            event = "BufEnter",
            -- optional for icon support
            requires = { 'nvim-tree/nvim-web-devicons' }
        }

        use {
            'nvim-tree/nvim-tree.lua',
            --cmd = { "NvimTreeToggle", "NvimTreeClose" },
            requires = {
                'nvim-tree/nvim-web-devicons', -- optional
            },
            config = function()
                require("config.nvimtree").setup()
            end
        }
        -- Buffer line
        use {
            "akinsho/nvim-bufferline.lua",
            tag = "*",
            event = "BufReadPre",
            wants = "nvim-web-devicons",
            after = "catppuccin",
            config = function()
                require("config.bufferline").setup()
            end,
        }

        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v2.x',
            requires = {
                -- LSP Support
                { 'neovim/nvim-lspconfig' }, -- Required
                {
                    -- Optional
                    'williamboman/mason.nvim',
                    run = function()
                        pcall(vim.cmd, 'MasonUpdate')
                    end,
                },
                { 'williamboman/mason-lspconfig.nvim' }, -- Optional

                -- Autocompletion
                { 'hrsh7th/nvim-cmp' },     -- Required
                { 'hrsh7th/cmp-nvim-lsp' }, -- Required
                { 'L3MON4D3/LuaSnip' },     -- Required
                { "hrsh7th/cmp-buffer" },
                { "hrsh7th/cmp-buffer" },
                { "saadparwaiz1/cmp_luasnip" },
                { "onsails/lspkind.nvim" },
            },
            config = function()
                require("config.lsp").setup()
            end
        }
        use {
            "windwp/nvim-autopairs",
            requires = {
                'VonHeikemen/lsp-zero.nvim'
            },
            config = function()
                require("nvim-autopairs").setup {}
                -- If you want insert `(` after select function or method item
                local cmp_autopairs = require('nvim-autopairs.completion.cmp')
                local cmp = require('cmp')
                cmp.event:on(
                    'confirm_done',
                    cmp_autopairs.on_confirm_done()
                )
            end
        }

        use { "rcarriga/nvim-dap-ui",
            requires = {
                "mfussenegger/nvim-dap",
                "theHamsta/nvim-dap-virtual-text",
                "mfussenegger/nvim-dap-python",
                "mfussenegger/nvim-jdtls"
            },
            config = function()
                require("config.dapconf").setup()
            end
        }



        if packer_bootstrap then
            print "Restart Neovim required after installation!"
            require("packer").sync()
        end
    end

    packer_init()

    local packer = require "packer"
    packer.init(conf)
    packer.startup(plugins)
end

return M
