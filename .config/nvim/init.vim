let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'puremourning/vimspector'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'projekt0n/github-nvim-theme'
Plug 'romainl/flattened'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

source ~/.vim/coc-init.vim

"let b:coc_enabled = !&diff

"set background=dark
"let g:solarized_termcolors=256
"let g:solarized_use16=1
"colorscheme solarized
"colorscheme flattened_dark
"colorscheme solarized8
"colorscheme github_dimmed
"
" Load the colorscheme
colorscheme github_dark_default

"set t_8f=\[[38;2;%lu;%lu;%lum
"set t_8b=\[[48;2;%lu;%lu;%lum
"set termguicolors
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! NormalNC ctermbg=NONE guibg=NONE

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
let g:python3_host_prog='~/py3nvim/bin/python'
let g:loaded_ruby_provider = 0
let g:loaded_python_provider=0

:tnoremap <Esc> <C-\><C-n>

if has('nvim')
  command! -nargs=* Term split | terminal <args>
  command! -nargs=* Termv vsplit | terminal <args>
endif

function WrapEquality(...)
    let curr_line = getline('.')
    let middle = a:0>=1 ? a:1 : "#"
    let wrapped = "print(" . curr_line . ")"
    let replacement = substitute(wrapped, middle, '==', '')
    call setline('.', replacement)
endfunction

function CommentTest(...)
    let pattern = a:0 > 1 ? a:1 : "^test"
    execute(':g/'.pattern.'/s//# \0/g')
endfunction

function WrapAllEquality(start)
    let s='^' . a:start
    execute(':g/'.s.'/call WrapEquality()')
endfunction

function DoAllRewrite()
    let currword = expand('<cword>')
    echo currword
    call WrapAllEquality(currword)
    call CommentTest()
endfunction




source ~/.vim/vimrc

