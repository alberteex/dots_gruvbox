"basic"
set nocompatible
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set nowrap
set ignorecase
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set clipboard+=unnamedplus


call plug#begin()
	Plug 'nvim-treesitter/nvim-treesitter'
	Plug 'hoob3rt/lualine.nvim'
	Plug 'windwp/nvim-autopairs'
	Plug 'ellisonleao/gruvbox.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

set background=dark
colorscheme gruvbox

lua << END

--syntax highlighting
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "cpp", "python", "xml", "yaml", "rust", "json", "toml" },
  sync_install = false,
  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
}

--lualine
require('lualine').setup()
options = { theme = 'gruvbox' }

--auto closing pairs
require("nvim-autopairs").setup {}

--theme config
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, 
  contrast = "", 
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")
END
