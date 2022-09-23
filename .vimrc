set term=xterm-256color

"===================================="
"==========  GENERAL CONF  =========="
"===================================="

set ruler
set numberwidth=2
syntax on
set mouse=a
set wrap
set nu rnu
set cursorline cursorcolumn
set mouse=a
set expandtab
set tabstop=2
set softtabstop=2 
set shiftwidth=2
set laststatus=2
set ignorecase 
set incsearch 
set noswapfile
set hlsearch 
set splitbelow
set splitright
"set listchars=space:.
"set list
"===================================="
"==========   TMUX  CONF   =========="
"===================================="
set background=dark
"set termguicolors
set t_Co=256
"let g:tokyonight_style = 'night' " available: night, storm
"let g:tokyonight_enable_italic = 1

"""""""""""" Vim-airline config"
let g:indent_guides_enable_on_vim_startup = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'

"=============================="
"=== Plugin Manager Install ==="
"=============================="

" Install vim-plug if not found

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


"=============================="
"====== Plugins  section ======"
"=============================="

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'ryanoasis/powerline-extra-symbols'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'elzr/vim-json'
Plug 'jiangmiao/auto-pairs' 
Plug 'davidhalter/jedi-vim' 
Plug 'vim-python/python-syntax'
Plug 'pearofducks/ansible-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'catppuccin/vim', { 'as': 'catppuccin'  }
Plug 'ghifarit53/tokyonight-vim'
Plug 'rust-lang/rust.vim'
call plug#end()


"=============================="
"======   Colorscheme    ======"
"=============================="

colorscheme catppuccin_mocha

"=============================="
"====   Vim airline conf   ===="
"=============================="

let g:indent_guides_enable_on_vim_startup = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'

"=============================="
"========== Nerdtree =========="
"=============================="

nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"=============================="
"==========   FZF    =========="
"=============================="

" FZF under current dir
nnoremap <silent> <C-f> :FZF<cr>

" FZF from Home dir
nnoremap <silent> <C-h> :FZF ~<cr>


filetype plugin indent on

set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

"colorscheme tokyonight
