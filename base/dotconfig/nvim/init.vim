set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Restore default cursor for edit mode
set guicursor=

" map esc to clear hilight
nnoremap <silent> <esc> :noh<cr><esc>
