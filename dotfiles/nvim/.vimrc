" General
let mapleader=' '
set autoread            " Updates file-content when changed by another process
set confirm             " Asks to save file if command fails because of unsaved changes
set encoding=utf8       " Internal encoding
set lazyredraw          " Do not redraw during macros
set nocompatible        " Disable compatibility with vi
set noerrorbells        " Turn off error-bells
set scrolloff=100       " Visible lines around current line
set ttyfast             " Efficient communication with the terminal
set wildmenu            " Enhance command-line completion

" Tabs
set autoindent          " Indent new line according to previous line
set expandtab           " Replace tab with spaces
set shiftwidth=4        " Number of spaces used during indentation for each tab
set softtabstop=4       " Number of spaces which are inserted when tab is pressed
set tabstop=4           " Number of space which are used to visualize a tab

" Searching
noremap <leader>h :noh<cr>|   " Remove search-highlights
set hlsearch            " Highlight search-matches
set ignorecase          " Case-insensitive search
set incsearch           " Highlight search-matches as characters are entered
set smartcase           " Case-sensitive search when using capital letters

" Appearance
filetype indent plugin on
highlight CursorLine cterm=none ctermbg=239
set cursorline          " Highlight current line
set mousehide           " Type to hide mouse and move mouse to unhide it
set noruler             " Do not display current line, column, etc.
set nu rnu             " Display combination of relative- and absolut line-numbers
set showmode            " Display current mode 
set title               " Show filename in title-bar
set wrap
syntax on

" Backup
set backupdir=~/.vim/backup/
set nobackup            " Do not store backup-files permanently
set noswapfile          " Disable swap-files
set writebackup         " Make a backup before overwriting a file
set viminfo

" Disable arrow-keys
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap! <left> <nop>
noremap! <right> <nop>
noremap! <up> <nop>
noremap! <down> <nop>

" Disable backspace
noremap <bs> <nop>
noremap! <bs> <nop>
