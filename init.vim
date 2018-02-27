set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
" source ~/.config/nvim/.vimrc

" Initial_Setup_Instructions:----------------------------------------------{{{1
" Install vim-plug:
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" then use :PlugInstall

" Plugin_support:
" pip install flake8 mypy yapf
" powerline fonts: https://github.com/powerline/fonts

" Themes:
" Create a colors directory ~/.config/nvim/colors
" Create a colors directory and then curl them with -o option to write a file

" Vimplug:-----------------------------------------------------------------{{{1

call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'vim-airline/vim-airline'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'zchee/deoplete-jedi'
call plug#end()

" Themes:------------------------------------------------------------------{{{1
" place in the colors directory ~/.config/nvim/colors using curl -o
" colorscheme badwolf "https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim

colorscheme molokai "https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
highlight cursorline ctermbg=236 ctermfg=none
highlight colorcolumn ctermbg=darkred

" BASIC SETTNGS:-----------------------------------------------------------{{{1

syntax enable
set number
set background=dark
set list
set showbreak=↳\ 
set visualbell
set cursorline
set title

" Tabs, spaces and wrapping
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set textwidth=79
set colorcolumn=+1

" FINDING AND AUTOCOMPLETE:------------------------------------------------{{{1

set wildmenu
set ignorecase
set smartcase
set showmatch

" SuperTab:----------------------------------------------------------------{{{1

let g:SuperTabDefaultCompletionType = "<c-n>" "set order of options to down

" Deoplete:----------------------------------------------------------------{{{1

let g:deoplete#enable_at_startup = 1

" UltiSnips:---------------------------------------------------------------{{{1

let g:UltiSnipsExpandTrigger="<C-j>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Ale:---------------------------------------------------------------------{{{1

let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" AIRLINE:-----------------------------------------------------------------{{{1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Virtualenv:--------------------------------------------------------------{{{1

" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif

" Remappings:--------------------------------------------------------------{{{1

" remap the Leader key:
let mapleader = ","
let maplocalleader = "\\"

" vim-autoformat
noremap <F3> :Autoformat<CR>

" disable the arrow keys:
" : in NORMAL mode
noremap <up> <Nop>
noremap <left> <Nop>
noremap <right> <Nop>
noremap <down> <Nop>

" : in INSERT mode
inoremap <up> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>
inoremap <down> <Nop>

" : in VISUAL mode
vnoremap <up> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>
vnoremap <down> <Nop>

" quick pairs in INSERT mode
inoremap <leader>' ''<ESC>i
inoremap <leader>" ""<ESC>i
inoremap <leader>* **<ESC>i
inoremap <leader>( ()<ESC>i
inoremap <leader>[ []<ESC>i
inoremap <leader>t[ [  ]<ESC>hi
inoremap <leader>{ {}<ESC>i
inoremap <leader>< <><ESC>i
" surround a word with ... pairs
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>hbi{<esc>lel
nnoremap <leader>< viw<esc>a><esc>hbi<<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>hbi[<esc>lel
nnoremap <leader>__ viw<esc>a__<esc>hbi__<esc>lel
" exit pair(s) to end of line:
inoremap <c-l> <ESC>A
" exit nested pair to within parent pair: **NOT WORKING**
inoremap <c-k> <ESC>la

"smash escape
inoremap jk <ESC>

" insert blank row
nnoremap <leader>r o<ESC>
nnoremap <leader>R O<ESC>

" navigating between vim tabs
nnoremap <leader>n <ESC>:tabn<CR>
nnoremap <leader>p <ESC>:tabp<CR>

" use relative numbering
" nnoremap <silent> <leader>u <ESC>:set relativenumber!<CR><ESC>
" inoremap <silent> <leader>u <ESC>:set relativenumber!<CR><ESC>i

" open vimrc in a split for a quick edit
nnoremap <leader>ev :tabe $MYVIMRC<cr>
" source the vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>
"
" -all-caps & continue in INSERT mode
inoremap <c-u> <esc>viwUea
" -all-caps & continue in NORMAL mode
nnoremap <c-u> viwUea<ESC>
" - search & highlighting
nnoremap <silent> <leader>nh :nohl<cr>

" Folding:-----------------------------------------------------------------{{{1

highlight Foldcolumn ctermfg=Darkgrey ctermbg=0 cterm=BOLD
highlight Folded ctermfg=Darkgrey ctermbg=NONE cterm=none
set foldcolumn=4
set foldmethod=marker
set foldlevelstart=0

function! MyFoldText()  "  {{{2
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart

  let onetab = strpart('           ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')

  let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction  "  2}}}

set foldtext=MyFoldText()

" end of vimrc