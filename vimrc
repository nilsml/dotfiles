set shell=/bin/bash
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
set nocompatible
set wildmenu
set cursorline
set incsearch
set foldmethod=syntax
set foldlevelstart=99
set t_Co=256
set term=xterm-256color
set termencoding=utf-8
"let g:solarized_termcolors = 256
set background=dark
"let g:solarized_termtrans = 1
"let g:molokai_original = 1
"let g:rehash256 = 1
" disable Background Color Erase (BCE) so that color schemes
" render properly when inside 256-color tmux and GNU screen.
" see also http://snk.tuxfamily.org/log/vim-256color-bce.html
"
" Powerline
let g:airline_powerline_fonts = 1
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set laststatus=2
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
if has("gui_running")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    set guifont=Inconsolata\ for\ Powerline:h15
  endif
 endif

set t_ut=
filetype plugin indent on
let g:syntastic_javascript_checkers = ['jsxhint']
"
"F# stuff
au BufRead,BufNewFile *.fs set filetype=fsharp
au BufRead,BufNewFile *.fsx set filetype=fsharp

function! NumberToggle()
  if(&relativenumber == 1)
    set relativenumber!
  else
    set relativenumber
  endif
endfunc
nnoremap <F2> :call NumberToggle()<cr>

" Removes trailing spaces
function! TrimWhiteSpace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

autocmd User Node
  \ if &filetype == "javascript" |
  \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
  \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
  \ endif

" Fuzzyfile
nmap fc :FufFileWithCurrentBufferDir<CR>
nmap fb :FufBuffer<CR>
nmap ft :FufTaggedFile<CR>
nmap fr :FufCoverageFile<CR>
nmap ff :FufFile<CR>
nmap fd :FufDir<CR>
nmap fj :FufJumpList<CR>
nmap fl :FufLine<CR>
nmap fq :FufQuickfix<CR>


set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" My Bundles here:
" vim-scripts repos
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
"Plugin 'altercation/vim-colors-solarized'
"Plugin 'kongo2002/fsharp-vim'
Plugin 'fsharp/vim-fsharp'
" Plugin 'lambdatoast/elm.vim'
Plugin 'elmcast/elm-vim'
Plugin 'xaviershay/tslime.vim'
Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'
Plugin 'rking/ag.vim'
Plugin 'cohama/lexima.vim'
Plugin 'edkolev/promptline.vim'
Plugin 'edkolev/tmuxline.vim'
"Plugin 'OmniSharp/omnisharp-vim'
"Bundle 'vim-scripts/vim-auto-save'
call vundle#end()

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" Promptline
let g:promptline_preset = {
        \'a' : [ promptline#slices#host() ],
        \'b' : [ promptline#slices#user() ],
        \'c' : [ promptline#slices#cwd() ],
        \'x' : [ promptline#slices#git_status(), promptline#slices#vcs_branch() ]}

let g:promptline_symbols = {
    \ 'vcs_branch' : '',
    \ 'space'      : ' '}

syntax enable
filetype off
filetype plugin indent on
colorscheme monokai
