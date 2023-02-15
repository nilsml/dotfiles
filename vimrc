set shell=/bin/zsh
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set number
set wildmenu
set cursorline
set incsearch
set foldmethod=syntax
set foldlevelstart=99
set termencoding=utf-8
set background=dark
let mapleader = ','
set guifont=FiraCode\ Nerd\ Font:h15
set encoding=utf-8
set t_ut=
filetype plugin indent on
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

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'arcticicestudio/nord-vim'
" Plug 'roxma/nvim-completion-manager'
Plug 'honza/vim-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
"Plug 'kongo2002/fsharp-vim'
Plug 'fsharp/vim-fsharp'
 "Plug 'lambdatoast/elm.vim'
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
"Plug 'edkolev/promptline.vim'
"Plug 'edkolev/tmuxline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"Plug 'OmniSharp/omnisharp-vim'
call plug#end()


syntax enable
filetype off
filetype plugin indent on
colorscheme nord
