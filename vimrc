set nocompatible

au BufWritePost .vimrc so $MYVIMRC

execute pathogen#infect()

let mapleader=';'

colorscheme monokai

" Use old regex engine for ruby syntax files. More: http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
set re=1

set title           " set terminal title
set cursorline      " hightlight current line
set showtabline=1   " only show tab bar when needed
set scrolloff=5     " scroll offset
set hidden          " allow background buffers without writing them
set hls             " highlight search
set colorcolumn=120

" temp switch to paste mode
set pastetoggle=<F2>

" Hybrid mode for line numbers
set relativenumber
set number

" Use spaces instead of tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" highlight whitespaces
set list
set listchars=tab:▸\ ,eol:¬,trail:·,extends:#,nbsp:.
" exclude html and xml files from tab highlighting
autocmd filetype html,xml set listchars-=tab:>.

" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

" auto remove trailing spaces on save
autocmd filetype java,html,javascript,ruby,haml,css,scss,coffee,erb autocmd BufWritePre <buffer> :%s/\s\+$//e

" clear search on leader + SPACE key. This does not clear search buffer
nnoremap <leader><space> :nohlsearch<cr>

" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" faster way to come out of INSERT mode
inoremap jj <ESC>

" Ctrl+S to save in insert mode"
imap <C-s> <esc>:w<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Double tab to toggle between buffers
nnoremap <Tab><Tab> :e#<CR>

"==== Tabs
" Tab navigations"
map <C-t> <esc>:tabnew<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap td  :tabclose<CR>
nnoremap tn  :tabnew<CR>

" Tab colors
hi TabLine        ctermfg=15 ctermbg=59 cterm=none gui=underline guibg=DarkGrey
hi TabLineSel     term=reverse ctermbg=12 cterm=none gui=undercurl guisp=Blue
hi TabLineFill    term=standout ctermbg=59 cterm=none gui=reverse guibg=#3c3d37

"==== Window management
" Open new split panes to right and bottom
set splitbelow
set splitright

" navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"==== NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

"==== CtrlP"
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

" show buffer list
nnoremap <leader>ll :CtrlPBuffer<cr>

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|node_modules|bower_components|vendors)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

"==== Ag
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

"==== EasyMotion
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

"==== Cosco
autocmd FileType javascript,css nnoremap <silent> <Leader>; :call cosco#commaOrSemiColon()<CR>
autocmd FileType javascript,css inoremap <silent> <Leader>; <c-o>:call cosco#commaOrSemiColon()<CR>

"use these libraries for Cosco
let g:used_javascript_libs = 'underscore,backbone,angularjs'


"==== Airline
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = '⎇'
" let g:airline_branch_prefix = '¤'
let g:airline_branch_prefix = 'ʎ'
let g:airline_readonly_symbol = 'R'
let g:airline_linecolumn_prefix = 'L'

" Backups & Files
set backup                    " Enable creation of backup file.
set backupdir=~/.vim/backups  " Where backups will go.
set directory=~/.vim/tmp      " Where temporary files will go.
