set nocompatible

execute pathogen#infect()

let mapleader=','

syntax on
filetype plugin indent on

"colorscheme github
"let g:solarized_termcolors=256
"set background=dark
"colorscheme solarized

let g:thematic#themes = {
\ 'bubblegum_light'  : { 'background':'light', 'colorscheme': 'bubblegum' },
\ 'bubblegum_dark' : { 'background':'dark', 'colorscheme':'bubblegum' },
\ 'pencil_light'  : { 'background':'light', 'colorscheme': 'pencil' },
\ 'pencil_dark' : { 'background':'dark', 'colorscheme': 'pencil' },
\ 'github': { 'background':'light', 'colorscheme': 'github'}
\ }

let g:thematic#theme_name = 'github'

runtime! plugin/sensible.vim

set title           " set terminal title
set cursorline      " hightlight current line
set showtabline=2   " always show tab bar
set scrolloff=5     " scroll offset
set hidden          " allow background buffers without writing them
set hls             " highlight search

" set noshowmode
" set noruler
set laststatus=0
" set noshowcmd

" temp switch to paste mode
set pastetoggle=<F2>

" by default show relative line numbers and absolute in 'insert mode'
set rnu
set number
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

" quickly jump to start and end of line
nnoremap ;s ^
nnoremap ;e $

" faster way to come out of INSERT mode
inoremap jj <ESC>

" Ctrl+S to save in insert mode"
imap <C-s> <esc>:w<CR>

" Tab navigations"
map <C-t> <esc>:tabnew<CR>
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>

" Buffer navigation
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>
nnoremap <Leader>g :e#<CR>

nnoremap <leader>n :NERDTreeToggle<CR>

" Window management
" Open new split panes to right and bottom
set splitbelow
set splitright

" navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" highlight the status bar when in insert mode
" if version >= 700
"   au InsertEnter * hi StatusLine ctermbg=111 guibg=#88b8f6
"   au InsertLeave * hi StatusLine ctermbg=250 guibg=#bbbbbb " status line color of github scheme
" endif


" CtrlP config"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Backups & Files
set backup                    " Enable creation of backup file.
set backupdir=~/.vim/backups  " Where backups will go.
set directory=~/.vim/tmp      " Where temporary files will go.

" Status line
" set statusline=%02n:%<%t                                          " filename
" set statusline+=%m%r%h%w                                          " flags
" set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]                   " encoding
" set statusline+=\ %{fugitive#statusline()}\ %{rvm#statusline()}   " git branch
" set statusline+=\ %=%-14.(%l\/%L,\ %c%V%)\ %p%{'%'}               " line and column

