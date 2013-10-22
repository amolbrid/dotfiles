set nocompatible

execute pathogen#infect()

let mapleader=','

syntax on
filetype plugin indent on

colorscheme github

set title           " set terminal title
set cursorline      " hightlight current line
set showtabline=2   " always show tab bar
set scrolloff=5     " scroll offset
set hidden          " allow background buffers without writing them
set hls             " highlight search

" temp switch to paste mode
set pastetoggle=<F2>

" by default show relative line numbers and absolute in 'insert mode'
set rnu
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Use spaces instead of tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" highlight extra white spaces with red background
highlight ExtraWhitespace ctermbg=196 guibg=#FF1100 ctermfg=white guifg=white
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" exclude html and xml files from tab highlighting
autocmd filetype html,xml set listchars-=tab:>.

" auto remove trailing spaces on save
autocmd filetype java,html,javascript,ruby,haml,css,scss autocmd BufWritePre <buffer> :%s/\s\+$//e

" clear search on leader + SPACE key. This does not clear search buffer
nnoremap <leader><space> :nohlsearch<cr>

" clear the search buffer when hitting return
" :nnoremap W :%s/ *$//g<cr><c-o><cr>

" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" faster way to come out of INSERT mode
inoremap jj <ESC>

nnoremap <leader>n :NERDTreeToggle<CR>

" Backups & Files
set backup                    " Enable creation of backup file.
set backupdir=~/.vim/backups  " Where backups will go.
set directory=~/.vim/tmp      " Where temporary files will go.

" Status line
set statusline=%<%t                                               " filename
set statusline+=%m%r%h%w                                          " flags
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]                   " encoding
set statusline+=\ %{fugitive#statusline()}\ %{rvm#statusline()}   " git branch
set statusline+=\ %=%-14.(%l\/%L,\ %c%V%)\ %p%{'%'}               " line and column

