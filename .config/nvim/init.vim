" This line makes pacman-installed global Arch Linux vim packages work.
source /usr/share/nvim/archlinux.vim

"Set leader
let mapleader=" "

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
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'airblade/vim-gitgutter'
Plug 'unblevable/quick-scope'

call plug#end()

" Make GitGutter work for my dotfiles repo
let g:gitgutter_git_args='--git-dir=$HOME/.cfg/ --work-tree=$HOME'

" Colorscheme (have to have this after vim-plug for path reasons)
colorscheme night-owl
syntax enable

" Fix weird night-owl default cursor line colors
highlight CursorLine cterm=bold guibg=#2b2b2b
highlight CursorColumn cterm=bold guibg=#2b2b2b
