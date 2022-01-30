" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

" Sepreate Config for CoC stuff
source $HOME/.config/nvim/coc-bindings.vim

" From Coc Readme
set updatetime=300

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Some funky tab stuff
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab
autocmd Filetype yaml setlocal softtabstop=2 shiftwidth=2
" Don't give |ins-completion-menu| messages.
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

"Set leader
let mapleader=","

" Open explorer on startup
" autocmd VimEnter * CocCommand explorer

" Vertical centering
autocmd InsertEnter * norm zz

"Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" Use system clipboard
set clipboard+=unnamedplus

" --Basic settings--
" Line numbers
set number relativenumber

" Search with / ignores case unless uppercase
set ignorecase
set smartcase

" True color
set termguicolors

" Mouse support
set mouse=a

" Cursor loc highlights
set cursorline
set cursorcolumn

" Color auto-highlight
let g:Hexokinase_highlighters = [ 'backgroundfull' ]
let g:Hexokinase_optInPatterns = 'full_hex,rgb,rgba,hsl,hsla,colour_names'

" Auto-completion
set wildmode=longest,list,full

"Fix splitting
set splitbelow splitright

" --Plugins--
call plug#begin('~/.config/nvim/plugged')
" Themes
Plug 'haishanh/night-owl.vim'
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Tags
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
" Misc
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'

call plug#end()

" Make GitGutter work for my dotfiles repo
let g:gitgutter_git_args='--git-dir=$HOME/.cfg/ --work-tree=$HOME'

" Colorscheme (have to have this after vim-plug for path reasons)
colorscheme night-owl

" Highlighting with TreeSitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" Fix weird night-owl default cursor line colors
highlight CursorLine cterm=bold guibg=#2b2b2b
highlight CursorColumn cterm=bold guibg=#2b2b2b

" Indent Line
lua <<EOF
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}
EOF
" --Keybindings--
nmap <leader>e :CocCommand explorer<CR>
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> Q ((getcmdtype() is# ':' && getcmdline() is# 'Q')?('q'):('Q'))
