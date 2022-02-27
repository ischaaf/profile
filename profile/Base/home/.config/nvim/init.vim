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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" nvim language server autocomplete
" Plug 'neovim/nvim-lspconfig'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/nvim-cmp'
"
" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'

" Python indentation
Plug 'Vimjas/vim-python-pep8-indent'
" Tabular to help tabularize code (required for markdown support)
Plug 'godlygeek/tabular'

""" Colorscheme
" Plug 'joshdick/onedark.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'Mofiqul/dracula.nvim'

""" Utilities
" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
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
" Plug 'takac/vim-hardtime'
" Multiple Cursors
Plug 'terryma/vim-multiple-cursors'

""" Hilighting
" Emmet for cool html coding
Plug 'mattn/emmet-vim'
" Asynchronous Linting Engine
" Plug 'dense-analysis/ale'
" Python
Plug 'ambv/black'
Plug 'stsewd/isort.nvim', { 'do': ':UpdateRemotePlugins' }
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
" Plug 'numirias/semshi'
" let g:semshi#excluded_hl_groups=[]
" Java
Plug 'artur-shaik/vim-javacomplete2'

Plug 'vim-syntastic/syntastic'
let g:syntastic_python_checkers=['mypy']

Plug 'chrisbra/Colorizer'

" Solidity syntax
Plug 'tomlion/vim-solidity'

Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'jose-elias-alvarez/null-ls.nvim'

" autoformat
autocmd BufWritePre *.ts lua vim.lsp.buf.formatting()
autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting()
autocmd BufWritePre *.css lua vim.lsp.buf.formatting()
autocmd BufWritePre *.sol lua vim.lsp.buf.formatting()


""" Completions
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf'
" [Completion Engine] Deoplete completion
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Python
" Plug 'zchee/deoplete-jedi'

""" Linting
" Python
Plug 'nvie/vim-flake8'
let g:flake8_show_in_file = 1

call plug#end()
filetype on

" Language server configs
" lua << EOF
"   -- vim.o.termguicolors = true
"   -- vim.cmd[[colorscheme dracula]]
"   -- Setup nvim-cmp.
"   local cmp = require'cmp'
"
"   cmp.setup({
"     snippet = {
"       expand = function(args)
"         vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
"         -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
"         -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
"         -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
"       end,
"     },
"     mapping = {
"       ['<C-d>'] = cmp.mapping.scroll_docs(-4),
"       ['<C-f>'] = cmp.mapping.scroll_docs(4),
"       ['<C-Space>'] = cmp.mapping.complete(),
"       ['<C-e>'] = cmp.mapping.close(),
"       ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
"       ['<CR>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
"       ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
"       -- ['<Tab>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
"     },
"     sources = cmp.config.sources({
"       { name = 'nvim_lsp' },
"       { name = 'vsnip' }, -- For vsnip users.
"       -- { name = 'luasnip' }, -- For luasnip users.
"       -- { name = 'ultisnips' }, -- For ultisnips users.
"       -- { name = 'snippy' }, -- For snippy users.
"     }, {
"       { name = 'buffer' },
"     })
"   })
"
"   local null_ls = require("null-ls")
"   null_ls.config({
"     sources = {
"       null_ls.builtins.formatting.prettier -- prettier, eslint, eslint_d, or prettierd
"     },
"   })
"
"   -- Setup lspconfig.
"   local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"   local nvim_lsp = require('lspconfig')
"   nvim_lsp["null-ls"].setup({})
"   nvim_lsp.rls.setup { capabilities = capabilities }
"   nvim_lsp.gopls.setup { capabilities = capabilities }
"   nvim_lsp.tsserver.setup({
"     on_attach = function(client, bufnr)
"       local ts_utils = require("nvim-lsp-ts-utils")
"       client.resolved_capabilities.document_formatting = false
"       client.resolved_capabilities.document_range_formatting = false
"       ts_utils.setup({
"         enable_formatting = true,
"         formatter = "prettier",
"       })
"       ts_utils.setup_client(client)
"     end,
"     capabilities = capabilities,
"   })
"   nvim_lsp.cssls.setup { capabilities = capabilities }
" EOF

" Configure vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:LanguageClient_serverCommands = {
       \ 'go': ['gopls']
       \ }
" Run gofmt on save
autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
let g:ale_linters = {
  \ 'go': ['gopls'],
  \}
let g:go_highlight_functions=1
let g:go_highlight_function_parameters=1
let g:go_highlight_function_calls=1
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_variable_declarations=0
let g:go_highlight_operators=1

autocmd FileType go nnoremap <buffer> <leader>d m':GoDef<CR>
autocmd FileType go nnoremap <buffer> <leader>r m':GoReferrers<CR>

" ================ Syntax association ===============
au BufRead,BufNewFile Jenkinsfile set filetype=groovy
au BufRead,BufNewFile *.jenkinsfile set filetype=groovy
au BufRead,BufNewFile .flake8 set filetype=dosini

" Linter Settings
autocmd FileType python let b:ale_fixers = ['isort', 'black']
autocmd FileType python let b:ale_fix_on_save = 1

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
" let g:onedark_termcolors=16
" packadd! dracula_pro
let g:dracula_colorterm = 0
set t_Co=256
colorscheme dracula
" highlight Normal ctermbg=NONE
" highlight nonText ctermbg=NONE

" ================ Black Settings =====================
" autocmd BufWritePre *.py execute ':Black'

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Indentation ======================
set autoindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

filetype plugin on
filetype indent on

" Display trailing spaces visually
set list listchars=tab:›·,trail:·

fun s:tabcolor()
  match TabChar "c"
  hi TabChar ctermfg=92
endfun

augroup ft_go
  autocmd!
  autocmd Syntax * match TabChar /\t/
  highlight link TabChar Comment
augroup end
" autocmd Syntax * hi TabChar ctermfg=92

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

" ================ Java Completion ========================
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" ================ Custom Commands ==================

command! -nargs=1 SetTab set shiftwidth=<args> softtabstop=<args> tabstop=<args>

" ================ Custom Mappings ==================
let mapleader = ";"

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
" autocmd FileType python nnoremap <silent> <Tab> :Semshi goto name next<CR>
" autocmd FileType python nnoremap <silent> <S-Tab> :Semshi goto name prev<CR>
nmap <silent> <S-Enter> o<esc>

" ================ [Experimental] Custom Mappings ==================
" SQL file hotkey to yank expression
autocmd FileType sql nnoremap <buffer> <leader>y {"*y}
autocmd FileType sql setlocal colorcolumn=100

" function MyCustomHighlights()
"     hi semshiLocal      ctermfg=437
" endfunction
" autocmd FileType python call MyCustomHighlights()

let g:clipboard = {
      \   'name': 'win32yank-wsl',
      \   'copy': {
      \      '+': 'win32yank.exe -i --crlf',
      \      '*': 'win32yank.exe -i --crlf',
      \    },
      \   'paste': {
      \      '+': 'win32yank.exe -o --lf',
      \      '*': 'win32yank.exe -o --lf',
      \   },
      \   'cache_enabled': 0,
      \ }


autocmd FileType solidity setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescriptreact setlocal shiftwidth=2 softtabstop=2 expandtab

" CoC configuration
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>y <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
