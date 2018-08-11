set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Testing out python semantic checker
Plugin 'numirias/semshi'

" Restore default cursor for edit mode
set guicursor=

" map esc to clear hilight
nnoremap <silent> <esc> :noh<cr><esc>
