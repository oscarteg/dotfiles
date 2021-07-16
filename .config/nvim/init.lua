require("helpers")
require("ale")
require("coc")
require("emmet")
require("lsp")
require("mappings")
require("nerdcommenter")
require("nerdtree")
require("options")
require("treesitter")
require("theming")

if has("termguicolors") then
    vim.o.termguicolors = true
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
-- Only if your version of Neovim doesn't have https://github.com/neovim/neovim/pull/12632 merged
vim._update_package_paths()

return require("packer").startup(
    function()
        -- Packer can manage itself
        use "wbthomason/packer.nvim"

        -- Lazy loading:
        -- Load on specific commands
        use {"tpope/vim-dispatch", opt = true, cmd = {"Dispatch", "Make", "Focus", "Start"}}

        use {
            "hoob3rt/lualine.nvim",
            requires = {"kyazdani42/nvim-web-devicons", opt = true}
        }

        use {"junegunn/fzf", run = fn["fzf#install"]}
        use "junegunn/fzf.vim"
        --  Completion
        use "dense-analysis/ale"
        use {"neoclide/coc.nvim", branch = "release"}
        --  Language
        use "tpope/vim-surround"
        use "mattn/emmet-vim"

        -- Load on a combination of conditions: specific filetypes or commands
        -- Also run code after load (see the "config" key)
        use {
            "mattn/emmet-vim",
            ft = {"html", "css", "typescriptreact", "javascriptreact"},
            cmd = "EmmetInstall",
            config = "vim.cmd[[EmmetInstall]]"
        }

        use "preservim/nerdcommenter"
        use {"yaegassy/coc-intelephense", run = "yarn install --frozen-lockfile"}
        -- --Integrations
        use "rizzatti/dash.vim"
        use "tpope/vim-fugitive"
        use "scrooloose/nerdtree"
        use "airblade/vim-gitgutter"
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        --  Styling
        use "mhartington/oceanic-next"
        use "morhetz/gruvbox"
        use "raphamorim/lucario"
        use "rafi/awesome-vim-colorschemes"
        use "yashguptaz/calvera-dark.nvim"
        use "sheerun/vim-polyglot"
        use "cseelus/vim-colors-lucid"
        use "ayu-theme/ayu-vim"
        --  Syntax
        use "styled-components/vim-styled-components"
        use "fatih/vim-go"
        use "rust-lang/rust.vim"
        use "jparise/vim-graphql"
        use "evanleck/vim-svelte"
        use "cespare/vim-toml"
        use "jordwalke/vim-reasonml"
        --  Other
        use "editorconfig/editorconfig-vim"

        use {
            "vhyrro/neorg",
            config = function()
                require("neorg").setup {
                    -- Tell Neorg what modules to load
                    load = {
                        ["core.defaults"] = {}, -- Load all the default modules
                        ["core.norg.concealer"] = {}, -- Allows for use of icons
                        ["core.norg.dirman"] = {
                            -- Manage your directories with Neorg
                            config = {
                                workspaces = {
                                    my_workspace = "~/neorg"
                                }
                            }
                        }
                    }
                }
            end
        }

        use {
            "folke/twilight.nvim",
            config = function()
                require("twilight").setup {}
            end
        }
    end
)
