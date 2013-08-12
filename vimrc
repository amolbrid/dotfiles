set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on

colorscheme github

" allow background buffers without writing them
set hidden

" show relative line numbers
set rnu

" highlight search
set hls

" hightlight current line
set cursorline

" always show tab bar
set showtabline=2

" temp switch to paste mode
set pastetoggle=<F2>

" Use spaces instead of tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" highlight whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Scroll offset
set scrolloff=5

" set terminal title
set title

" exclude html and xml files from tab highlighting
autocmd filetype html,xml set listchars-=tab:>.

let mapleader=','

" clear search on ENTER key. This does not clear search buffer
:nnoremap <CR> :nohlsearch<cr>

" clear the search buffer when hitting return
" :nnoremap W :%s/ *$//g<cr><c-o><cr>

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" highlight extra white spaces with red background
highlight ExtraWhitespace ctermbg=196 guibg=#FF1100 ctermfg=white guifg=white
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" auto remove trailing spaces on save
autocmd filetype java,html,javascript,ruby,haml,css,scss autocmd BufWritePre <buffer> :%s/\s\+$//e

autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

" Backups & Files
set backup " Enable creation of backup file.
set backupdir=~/.vim/backups " Where backups will go.
set directory=~/.vim/tmp " Where temporary files will go.

" Status line
" filename
set statusline=%<%t
" flags
set statusline+=%m%r%h%w
" encoding
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]
" git branch
set statusline+=\ %{fugitive#statusline()}\ %{rvm#statusline()}
" line and column
set statusline+=\ %=%-14.(%l\/%L,\ %c%V%)\ %p%{'%'}

