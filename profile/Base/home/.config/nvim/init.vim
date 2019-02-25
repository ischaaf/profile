set history=1000                "Store lots of :cmdline history
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set errorbells                  "Beep when error occurs
set autoread                    "Reload files changed outside vim
set backspace=indent,eol,start  "Make backspace work properly
set laststatus=2                "Turn on status line
set exrc                        "Enable per-directory .vimrc files
set secure                      "Disable unsafe commands in local .vimrc files
set incsearch                   "Search incrementally instead of after I press enter
set number                      "Show line numbers
set nofoldenable                "Disable folding

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" Adjust esckeys option timeout length
set timeoutlen=100
set ttimeoutlen=0

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" turn on syntax highlighting
syntax enable

" Automatically remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

" ================ Install plugins =================
filetype off
call plug#begin('~/.local/share/nvim/plugged')
" Vundle setup
Plug 'gmarik/Vundle.vim'

" Python indentation
Plug 'Vimjas/vim-python-pep8-indent'
" Tabular to help tabularize code (required for markdown support)
Plug 'godlygeek/tabular'

""" Colorscheme
Plug 'joshdick/onedark.vim'

""" Utilities
" Adding Adding commenting functionality
Plug 'scrooloose/nerdcommenter'
" Airline status bar
Plug 'bling/vim-airline'
" Git gutter
Plug 'airblade/vim-gitgutter'
" File search
Plug 'ctrlpvim/ctrlp.vim'
" NERD Tree
Plug 'scrooloose/nerdtree'
" Hard time mode to help learn vim
Plug 'takac/vim-hardtime'
" Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

""" Hilighting
" Emmet for cool html coding
Plug 'mattn/emmet-vim'
" Asynchronous Linting Engine
Plug 'w0rp/ale'
" Rust
Plug 'rust-lang/rust.vim'
" Golang
Plug 'fatih/vim-go'
" Terraform
Plug 'hashivim/vim-terraform'
" Javascript
Plug 'pangloss/vim-javascript'
" Typescript
Plug 'leafgarland/typescript-vim'
" JSX
Plug 'mxw/vim-jsx'
" PostCSS
Plug 'alexlafroscia/postcss-syntax.vim'
" Kotlin
Plug 'udalov/kotlin-vim'
" Testing out python semantic checker
Plug 'numirias/semshi'


""" Completions
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
" [Completion Engine] Deoplete completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python
Plug 'zchee/deoplete-jedi'

""" Linting
" Python
Plug 'nvie/vim-flake8'
let g:flake8_show_in_file = 1

call plug#end()
filetype on

" ================ Syntax association ===============
au BufRead,BufNewFile Jenkinsfile set filetype=groovy
au BufRead,BufNewFile *.jenkinsfile set filetype=groovy
au BufRead,BufNewFile .flake8 set filetype=dosini

" ================ Deoplete Settings ==============
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Adjust delay to 30 ms
call deoplete#custom#option('auto_complete_delay', 30)

" Silence the  messages in the command line
" such as 'The only match', 'Pattern not found', 'Back at original", etc.
set shortmess+=c

" ================ Emmet Settings ===================
imap <expr> <c-j> emmet#expandAbbrIntelligent("\<c-j>")

" ================ Hard Time Settings ===============
" let g:hardtime_default_on = 1

" ================ CtrlP Settings ===================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_extensions = ['bookmarkdir']
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_custom_ignore = 'node_modules\|\.git$\|\.pyc$|.cache|.DS_Store|.terraform'
let g:ctrlp_show_hidden = 1

" ================ NERDTree Settings ================
let NERDTreeIgnore = ['\.\.$', '\.$', '__pycache__', 'node_modules', '\.git$', '\.pyc$', '.cache', '.DS_Store', '.terraform']
let NERDTreeShowHidden=1

" ================ GitGutter Settings ===============
set signcolumn=yes

" ================ Theme =====================
let g:onedark_termcolors=16
colorscheme onedark

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set autoindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

" Display trailing spaces visually
set list listchars=trail:·,tab:»·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

set wildignore+=__pycache__

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Custom Commands ==================

command! -nargs=1 SetTab set shiftwidth=<args> softtabstop=<args> tabstop=<args>

" ================ Custom Mappings ==================
let mapleader = ","

" Close a buffer permanently
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
" Shortcut to toggle NERDTree
map <leader>n :NERDTreeToggle<CR>
" remove hilighting from search on esc
nnoremap <esc> :noh<return><esc>


" Restore default cursor for edit mode
set guicursor=

" map esc to clear hilight
nnoremap <silent> <esc> :noh<cr><esc>
nmap <silent> <Tab> :Semshi goto name next<CR>
nmap <silent> <S-Tab> :Semshi goto name prev<CR>
