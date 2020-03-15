""""""""""""""""""""""""""""""
" Plug - Plugin manager config
"""""""""""""""""""""""""""""""

" Install Plug if it's not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Solarized color theme
Plug 'iCyMind/NeoSolarized'
" Fzf
Plug 'junegunn/fzf'

call plug#end()

"""""""""""
" Settings
"""""""""""
colorscheme NeoSolarized    " Enable solarized theme
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab cvompletions
set termguicolors           " enable true color support
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
