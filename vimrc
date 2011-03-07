"" Much taken from http://stevelosh.com/blog/2010/09/coming-home-to-vim/

"" Needed on some linux distros.
"" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

"" Fuck you /bin/vi
set nocompatible

"" Change leader key from \ to ,
let mapleader = ","

"" Force hjkl movement!!!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

"" Window options
set bg=dark
set background=dark                 "easy on the eye
set modelines=1                     "always show the filename
set ruler                           "always show line and coll numbers
set laststatus=2
set statusline="%l/%L,%c%V"

"" Longer history for commands and searches (default: 20)
set history=1000

" Allow ;w, rather than shift : unshift w etc.
nnoremap ; :

"" Display trailing whitespace and tabs.
" FAILED - This never worked well, and made mouse copy break.
"set list listchars=tab:>-,trail:CUNT
"set list listchars=tab:>-

"" Searching/moving 
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set matchpairs+=<:>                 "allow % to bounce between <> too
nnoremap <leader><space> :noh<cr>

set title                           "set the terminal title
set backspace=indent,eol,start      "make backspaces delete sensibly
set wildmode=longest,list           "better tab filename completion
set hidden                          "Allow buffer changes with unsaved changes.

"" Tab options - whitespace!
set tabstop=4           "indentation levels every four columns
set expandtab           "convert all tabs typed to spaces
set shiftwidth=4        "indent/outdent by four columns
set shiftround          "indent/outdent to nearest tabstop
filetype indent on
filetype plugin on

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Force syntax highlighing of long files.
map <F3> :syn sync fromstart<CR>

" Run perltidy on selection with F5
map <F5> !perltidy --perl-best-practices --maximum-line-length=100 -q<CR> 
" ... with ,p
map <leader>p !perltidy --perl-best-practices --maximum-line-length=100 -q<CR>

" Remove all trailing whitespace in file
nnoremap <leader>W :%s/\s\+$//g<cr>:let @/=''<CR>
" Hitting jj in insert-mode mimics escape
inoremap jj <ESC>

"" Syntax highlighting options
syntax on                                       "turn on syntax highlighting
syntax enable                                   "same as above I guess
au BufNewFile,BufRead *.html set ft=mason       "mason highlight .html files
au BufNewFile,BufRead *handler set ft=mason     "mason highlight handler files
au BufNewFile,BufRead *.mas set ft=mason        "mason highlight .mas files
au BufNewFile,BufRead *.t set ft=perl           "perl highlight .t files
au BufNewFile,BufRead *.res set ft=perl         "perl highlight .res files

set viminfo='10,\"100,:20,%,n~/.viminfo "(and next line) remember and jump to my last file position
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"===========================================================================
" POD FOLDING - za will toggle local POD, zR expands all file, zM shrinks all file
"---------------------------------------------------------------------------
" fold POD blocks between =... and =cut
set foldexpr=getline(v:lnum)=~'^=[a-bd-z]'?1:(getline(v:lnum-1)=~'^=cut'?0:foldlevel(v:lnum-1))
set foldmethod=expr

" pretty up the fold marker for POD
set foldtext=v:folddashes.'\ '.(v:foldend-v:foldstart+1).'\ lines:\ '.substitute(getline(v:foldstart),'^=[^\ ]*\ ','','')

highlight Folded term=standout ctermfg=4 ctermbg=0

"===========================================================================
" GENERAL FOLDING SANITY
"---------------------------------------------------------------------------
" turn off annoying auto-opening of folds on cursor movement
set foldopen=mark,percent,quickfix,search,tag,undo
set foldclose=

