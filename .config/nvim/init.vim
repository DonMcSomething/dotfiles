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
Plug 'vim-airline/vim-airline-themes'
" Code completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Terminal things
Plug 'kassio/neoterm'
"Bufferline
Plug 'akinsho/bufferline.nvim'
Plug 'vim-airline/vim-airline'
" Tags
Plug 'alvan/vim-closetag' "-- autoclose pairs
Plug 'tpope/vim-surround' "-- change surrouding quotes and stuff
" Misc
Plug 'lukas-reineke/indent-blankline.nvim' "-- indent line
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} "-- highlighting
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } "-- highlights bracket pairs and stuff
Plug 'airblade/vim-gitgutter' "-- git stuff
Plug 'unblevable/quick-scope' "-- leter highlights for jump commands
Plug 'ryanoasis/vim-devicons' "-- filetype icons
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

"Terminal stuff
let g:neoterm_callbacks = {}
    function! g:neoterm_callbacks.before_new()
      if winwidth('.') > 100
        let g:neoterm_default_mod = 'botright vertical'
      else
        let g:neoterm_default_mod = 'botright'
      end
    endfunction

" Tabline stuff
lua << EOF
require("bufferline").setup{
  options = {
    numbers = "none",
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    middle_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    right_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    -- NOTE: this plugin is designed with this icon in mind,
    -- and so changing this is NOT recommended, this is intended
    -- as an escape hatch for people who cannot bear it for whatever reason
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    --- name_formatter can be used to change the buffer's label in the bufferline.
    --- Please note some names can/will break the
    --- bufferline so use this at your discretion knowing that it has
    --- some limitations that will *NOT* be fixed.
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = coc,
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local s = " "
     for e, n in pairs(diagnostics_dict) do
	local sym = e == "error" and " "
          or (e == "warning" and " " or "" )
	s = s .. n .. sym
     end
     return s
    end,
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
       if vim.bo[buf_number].filetype ~= "terminal" then
         return true
       end
       -- filter out by buffer name
       if vim.fn.bufname(buf_number) ~= "zsh" then
         return true
       end
    end,
    offsets = {{filetype = "coc-explorer", text = "File Explorer", text_align = "left"}},
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'id',
  }
}
EOF

nnoremap <silent>[b :BufferLineCycleNext<CR>
nnoremap <silent>b] :BufferLineCyclePrev<CR>

" Airline stuff
let g:airline_theme='night_owl'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_filetype_overrides = {'coc-explorer':  [ 'CoC Explorer', '' ]}
let g:airline_skip_empty_sections = 1

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
