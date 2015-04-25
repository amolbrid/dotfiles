set nocompatible

execute pathogen#infect()
"
" reload .vimrc when modified and saved from vim
au BufWritePost .vimrc so $MYVIMRC

let mapleader=','

syntax on
filetype plugin indent on

"colorscheme github
" let g:solarized_termcolors=256
"set background=dark
"colorscheme solarized
colorscheme monokai

" Use old regex engine for ruby syntax files. More: http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
set re=1

set title           " set terminal title
" set cursorline      " hightlight current line
set showtabline=1   " only show tab bar when needed
set scrolloff=5     " scroll offset
set hidden          " allow background buffers without writing them
set hls             " highlight search

" set noshowmode
" set noruler
set laststatus=2
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
" set listchars=tab:>.,trail:.,extends:#,nbsp:.
set listchars=tab:▸\ ,eol:¬,trail:·,extends:#,nbsp:.


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
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
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

" EasyMotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-s)

" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>a <Plug>(easymotion-sl)

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Backups & Files
set backup                    " Enable creation of backup file.
set backupdir=~/.vim/backups  " Where backups will go.
set directory=~/.vim/tmp      " Where temporary files will go.

" let g:airline_powerline_fonts = 1

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = '⎇'
let g:airline_branch_prefix = '¤'
" let g:airline_branch_prefix = 'ʎ'
let g:airline_readonly_symbol = 'R'
let g:airline_linecolumn_prefix = 'L'
" Status line
" set statusline=%02n:%<%t                                          " filename
" set statusline+=%m%r%h%w                                          " flags
" set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}]                   " encoding
" set statusline+=\ %{fugitive#statusline()}\ %{rvm#statusline()}   " git branch
" set statusline+=\ %=%-14.(%l\/%L,\ %c%V%)\ %p%{'%'}               " line and column

hi TabLine        ctermfg=15 ctermbg=59 cterm=none gui=underline guibg=DarkGrey
hi TabLineSel     term=reverse ctermbg=12 cterm=none gui=undercurl guisp=Blue
hi TabLineFill    term=standout ctermbg=59 cterm=none gui=reverse guibg=#3c3d37

