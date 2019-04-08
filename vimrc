" PLUGIN MANAGER TO INSTALL EXTERNAL PLUGINS

call plug#begin('~/.local/share/nvim/plugged')
" General utility plugins
Plug 'Shougo/unite.vim' 
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'ryanoasis/vim-devicons'
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/calendar.vim'

"Colorscheme Plugins
Plug 'rakr/vim-one' 
Plug 'ayu-theme/ayu-vim' 

" Language specific plugins
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'  
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'  
Plug 'elmcast/elm-vim'
Plug 'rust-lang/rust.vim'
call plug#end()

"use jk to exit insert mode
inoremap jj <Esc>

" Set true color for themes
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Set color theme
syntax enable
set background=dark
let ayucolor="mirage"
colorscheme ayu

" Setting standard file encoding
set encoding=utf8

" No special per file vim override configs
set nomodeline

" Stop word wrapping
set nowrap

  " Except... on Markdown. That's good stuff.
  autocmd FileType markdown setlocal wrap

" Adjust system undo levels
set undolevels=100

" Use system clipboard
set clipboard=unnamed

" Setting tab width and convert tabs to spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Don't let Vim hide characters or make loud dings
set conceallevel=1
set noerrorbells

" Number gutter
set number

"Set relative number for easy jump to line
set relativenumber

" Use search highlighting
set hlsearch

" Space above/beside cursor from screen edges
set scrolloff=1
set sidescrolloff=5

" Use space as the leader key
let mapleader="\<SPACE>"

" Disable mouse support
set mouse=r
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" let arrow keys to resize panes
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>

" Disable arrow keys in insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Space-Space to open recently opened buffer
nmap <Leader><Leader> <c-^>

" Tab => next buffer ; Shift+Tab => Previous buffer
nnoremap <Tab> :bnext!<CR>
nnoremap <S-Tab> :bprev!<CR><Paste>

" Indent code
let g:indentLine_enabled = 1
let g:indentLine_char = ""

" Show the following stuff on the vim airline
let g:airline#extensions#tabline#enabled=1
set laststatus=2

" Space-P or Space-T opens fuzzy finder - FZF
nnoremap <Leader>p :Files<CR>

" Space+Backtick ` to toggle file tree ;;; Space+Tilde ~ to toggle file tree
" from current buffer location
map ` :NERDTreeToggle <CR>

" Tabbable dropdown for auto completion:
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Vim easy motion : Let's move around and find things easily, eh?
map  <leader><leader>f <Plug>(easymotion-bd-w)
nmap <leader><leader>f <Plug>(easymotion-overwin-w)

" Use eslint for ale
let g:ale_linters = {'javascript': ['eslint']}

" Enable google task and calendar integration for calendar
let g:calendar_google_calendar = 0
let g:calendar_google_task = 0

"Disable swap file
set noswapfile

"Auto format rust on save using Rustfmt
let g:rustfmt_autosave = 1
