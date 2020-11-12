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
" set t_Co=256
" set term=xterm-256color
set termencoding=utf-8
set background=dark
let mapleader = ','
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

"fzf
set rtp+=/usr/local/opt/fzf

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
" nmap fc :FufFileWithCurrentBufferDir<CR>
" nmap fb :FufBuffer<CR>
" nmap ft :FufTaggedFile<CR>
" nmap fr :FufCoverageFile<CR>
" nmap ff :FufFile<CR>
" nmap fd :FufDir<CR>
" nmap fj :FufJumpList<CR>
" nmap fl :FufLine<CR>
" nmap fq :FufQuickfix<CR>
" map <Leader> <Plug>(easymotion-prefix)

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'arcticicestudio/nord-vim'
" Plug 'roxma/nvim-completion-manager'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
"Plug 'kongo2002/fsharp-vim'
Plug 'fsharp/vim-fsharp'
" Plug 'lambdatoast/elm.vim'
Plug 'elmcast/elm-vim'
Plug 'xaviershay/tslime.vim'
Plug 'moll/vim-node'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rking/ag.vim'
Plug 'cohama/lexima.vim'
Plug 'edkolev/promptline.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'OmniSharp/omnisharp-vim'
call plug#end()

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
colorscheme nord
