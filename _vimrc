" Dmitos-vim-config

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

"===========================
"1. CONFIGURACION GENERICAS
"===========================

set nocompatible " deshabilita la compatibilidad con vi
set history=1000 " aumenta el historial

"===========================
"2. PLUGINS
"===========================
"
"        ===========================
"        2.1. VIM-PLUG
"        ===========================

call plug#begin('~/.vim/plugged/')

" Make sure you use single quotes

" Plug-ins
Plug 'ap/vim-buftabline' " abre tabs por cada archivo editado
Plug 'scrooloose/nerdcommenter' " comenta las lineas ,cc
Plug 'scrooloose/nerdtree' " un arbol para buscar archivos ,nt
Plug 'vim-python/python-syntax'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'altercation/vim-colors-solarized'
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'majutsushi/tagbar'
" Plug 'davidhalter/jedi-vim'
Plug 'klen/python-mode'
"Plug 'seletskiy/vim-autosurround'
Plug 'jiangmiao/auto-pairs'
" Initialize plugin system
call plug#end()

"        =====================
"        2.2. BUNDLE
"        =====================

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'seletskiy/vim-autosurround'
    
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
 
" All of your Plugins must be added before the following line


" Plugin 'tpope/vim-surround'
" Plugin 'valloric/youcompleteme'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"


"===========================
"3. CONFIGURACION DE
"       ARCHIVOS
"===========================

set noswapfile "el swap ya casi el del pasado
set nobackup "hay mejores maneras de hacer backup (ver GIT

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4 " remueve el pseudo-TAB
set shiftwidth=4 " el espacio del autoindentado
set textwidth=79
set autoindent " siempre activo auto indentado
set fileformat=unix

" utf8 soporte
set encoding=utf-8 " siempre usar unicode( windows :/
set backspace=indent,eol,start " backspace siempre funciona en modo insert


"===============================
"4. DEFINIR TECLAS Y FUNCIONES
"===============================

let mapleader="," " mas comodidad con la tecla

"NERDTree: defino la tecla nt para abrir NERDTree - en minusculas para mas
"facil
command NT NERDTree
nmap <Leader>nt :NERDTreeToggle<cr>

"como manejarse con los buffer.. muy interesante
set hidden
nnoremap <C-N> :bprev<CR>
nnoremap <C-M> :bnext<CR>

"tagabar - mapeo
nmap <F8> :TagbarToggle<CR>


"===============================================

" allow plugins,by file type (required for plugins!)
filetype plugin on
filetype indent on

let g:python_highlight_all = 1
" let g:syntastic_python_checkers = ['pylint']
" tab length exceptions on some file types
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType htmldjango setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4 softtabstop=4

" always show status bar
set ls=2

" incremental search
set incsearch
" highlighted search results
set hlsearch

" syntax highlight on
syntax on

" show line numbers
set nu


" Comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" Disabled by default because preview makes the window flicker
set completeopt-=preview

set background=dark
colorscheme solarized
set noshowmode


" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

"  py-Mode ---------------------

let g:pymode_python = 'python3'

" Jedi-vim ------------------------------

" let g:jedi#auto_initialization = 0
" let g:jedi#show_call_signature = 1

" All these mappings work only for python code:
" Go to definition

" let g:jedi#goto_command = ',d'
" Find ocurrences
" let g:jedi#usages_command = ',o'
" Find assignments
" let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
" nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" utf8 soporte
set encoding=utf-8

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
