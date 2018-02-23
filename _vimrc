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
"2. VIM-PLUG - PLUGINS
"===========================

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

" Initialize plugin system
call plug#end()

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


"===============================================

" allow plugins,by file type (required for plugins!)
filetype plugin on
filetype indent on

let g:python_highlight_all = 1
let g:syntastic_python_checkers = ['pylint']
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


" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" Jedi-vim ------------------------------

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" utf8 soporte
set encoding=utf-8

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
