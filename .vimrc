set nocompatible          "NO U Vi...

call pathogen#infect()
call pathogen#helptags()
syntax enable
let mapleader=","         "Change mapleader


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color scheme settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized
highlight LineNr ctermbg=256 ctermfg=23
highlight CursorLine ctermbg=23 ctermfg=255
highlight TabLine ctermfg=255 ctermbg=23
highlight TablineFill cterm=underline ctermfg=255 ctermbg=23
highlight TabLineSel ctermbg=255 ctermfg=1


"Set temporary storage directories
set undodir=~/.vim/tmp/undo
set nobackup
set noswapfile

set ignorecase            "Ignore case when searching
set smartcase
set hlsearch              "Highlight search terms"
set incsearch             "Highlight search terms dynamically as they are being typed
set laststatus=2         "always show status bar
set showmode              "always show the current mode
set title                 "Show the current filename in the titlebar
set noerrorbells          "shhhhhh...

set showmatch             "Show matching brackets / parenthesis
set expandtab             "Expand tabs to spaces
set smarttab              "Tab inserts spaces
set softtabstop=2         "Tab inserts 2 spaces
set shiftwidth=2          "Number of spaces used for indenting
set list
set listchars=tab:>-

set autochdir             "set the current files dir as the current"
set autoindent            "use indent from last line on new line
set smartindent           "unless closing a bracket then we jump to that indent location
set backspace=indent,eol,start
set number                "turn line numbers on
set cursorline            "highlight cursors line
set ruler                 "show the cursors position in the status bar
set mouse=a               "allow mouse in all modes
set nowrap                "Do not wrap lines
set history=1000          "Increase history buffer to 1000
set autoread              "Auto read remote / outside changes to the open file
set hidden                "Remember buffer history / undo when bringing a buffer to foreground
set clipboard=unnamed     "Yank to the to system clipboard by default

set formatoptions=
set formatoptions+=c " Format comments
set formatoptions+=r " Continue comments by default
set formatoptions+=o " Make comment when using o or O from comment line
set formatoptions+=q " Format comments with gq
set formatoptions+=n " Recognize numbered lists
set formatoptions+=2 " Use indent from 2nd line of a paragraph
set formatoptions+=l " Don't break lines that are already long
set formatoptions+=1 " Break before 1-letter words

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Panel, window, and tab management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map window / panel switching to <leader> up, right ,down, left
map <leader>w<up>    <C-W><up>
map <leader>w<right> <C-W><right>
map <leader>w<down>  <C-W><down>
map <leader>w<left>  <C-W><left>

"map window splitting to <leader>sw (split window) - up, right, down, left
map <leader>sw<up>    :topleft new<CR>
map <leader>sw<right> :botright vnew<CR>
map <leader>sw<down>  :botright new<CR>
map <leader>sw<left>  :topleft vnew<CR>

"map panel splitting to <leader>sp (split panel) - up, right, down, left
map <leader>sp<up>    :leftabove new<CR>
map <leader>sp<right> :rightbelow vnew<CR>
map <leader>sp<down>  :rightbelow new<CR>
map <leader>sp<left>  :leftabove vnew<CR>

"map fast window resizing
map + <C-W>+
map - <C-W>-

"map new & close tabs
map <leader>tn :tabnew<CR>
map <leader>tc :tabclose<CR>

"map next & previous tabs
map <leader>t<right> gt
map <leader>t<left> gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => String / file manipulation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"strip all trailing whitespace from a file
nnoremap <leader>ws :%s/\s\+$//<CR>:let @/=''<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Convenience mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command W w "because i'm always typing W


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Extras
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Fugitive (remap for convenience)
noremap :gs :Gstatus
noremap :gc :Gcommit
set statusline +=%{fugitive#statusline()}

"CtrlP
let g:ctrlp_map = '<leader>p'

"NERDTree
let g:NERDTreeDirArrows=0

"Syntastic
"jslint options
let g:syntastic_javascript_jslint_conf = "--browser --es5 --white --predef=$"

" Disable arrow keys for insert and normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
