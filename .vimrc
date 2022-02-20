set term=xterm-256color

"""""""""""" Plug Manager Install 
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"""""""""""" Plugging section
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
Plug 'ghifarit53/tokyonight-vim'
call plug#end()

"""""""""""" Nerdtree 
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"""""""""""" FZF
" FZF under current dir
nnoremap <silent> <C-f> :FZF<cr>
" FZF from Home dir
nnoremap <silent> <C-h> :FZF ~<cr>

"""""""""""" General Customization "

set ruler
set numberwidth=2
syntax on
set mouse=a
set wrap
set number " allow line numbers
set cursorline " highlight current line
set mouse=a
set expandtab " On pressing tab, insert 4 spaces
set tabstop=2 " show existing tab with 4 spaces width
set softtabstop=2 
set shiftwidth=2 " when indenting with '>', use 4 spaces width
set laststatus=2
set ignorecase " ignore case in search
set incsearch " show search results as you type
set noswapfile " disable the swapfile
set hlsearch " highlight all results
set splitbelow
set splitright
"set listchars=space:.
"set list

"""""""""""" Tmux color fix
"set background=dark
set termguicolors

let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 1

colorscheme tokyonight
"""""""""""" Vim-airline config"
let g:airline_theme="tokyonight"
let g:indent_guides_enable_on_vim_startup = 1
let g:airline_section_z = '%3p%% %3l/%L:%3v'
"""""""""""" NerdTree config 

