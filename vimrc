call plug#begin('~/.local/share/nvim/plugged')

"Utility plugins
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" for typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'
" weirdly, loading tsuquyomi after typescript-vim breaks
" syntax highlighting from typescript-vim
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Let traverse our documents faster
Plug 'easymotion/vim-easymotion'
" Let's add some jazz
Plug 'itchyny/lightline.vim'
Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
" Fancy ones but not necessarily required
" Generate matching bracket pair
Plug 'jiangmiao/auto-pairs'
" generate closing tag for html/jsx
Plug 'alvan/vim-closetag'
" Show git diff in gutter
Plug 'airblade/vim-gitgutter'
" Mainly to make 'set autoread' work correctly
Plug 'tmux-plugins/vim-tmux-focus-events'
" To highlight the lines i yanked. I don't use y<n>y because i have no idea
" how much stuff i yanked
Plug 'machakann/vim-highlightedyank'
call plug#end()

" turn syntax highlighting on
syntax on
" the below line turns on three things at once
" filetype on
" plugin on
" indent on
" filetype on - vim will try setting the filetype for current file and raise a FileType event, which can 
" be used by plugins for syntax highlighting
" plugin - Plugins associated with a particular file are loaded when a file is loaded
" indent - indent.vim for a particular file type is loaded when the file is loaded
filetype plugin indent on

" Let's add some jazz
set background=dark
" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
colorscheme OceanicNext 

" relative line numbering, yo
set relativenumber
" but we don't want pure relative line numbering. The line where the cursor is should show absolute line number
set number

" map space to leader key
let mapleader="\<Space>"

" map escape key to jj 
:imap jj <Esc>

" don't want case sensitive searches
set ignorecase
" but still want search to be smart. If i type a upper case thing, do a case
" sensitive search
set smartcase

" show existing tab with 2 spaces width
set tabstop=2

" when indenting with '>', use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 2 spaces
set expandtab

" map ctrlp to open fzf file search 
nnoremap <C-p> :Files<CR>

" map Ctrl-q (terminals don't recognize ctrl-tab) (recent files) to show all 
" files in the buffer
nnoremap <leader>f :Buffers<CR>
nnoremap <C-i> :Buffers<CR>
inoremap <C-i> <Esc>:Buffers<CR>

" Tab in insert mode will activate autocomplete
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

" Substitute occurances of word under cursor 
nnoremap <leader>s :s/\<<C-r><C-w>\>/

map <leader>a to search word under cursor in the whole project
nnoremap <leader>a :exe 'Ag!' expand('<cword>')<cr>
" I like my cmd+s for saving files. In insert mode!
" The terminal (or iterm) does not have support for anything related to
" Command key
" Hence need to hack stuff - https://stackoverflow.com/questions/33060569/mapping-command-s-to-w-in-vim
inoremap <C-s> <Esc>:w<CR>i
nnoremap <C-s> :w<CR>

" toggle NERDTree show/hide using <C-n> and <leader>n
map <leader>n :NERDTreeToggle<CR>

" reveal open buffer in NERDTree
nmap <leader>r :NERDTreeFind<CR>

" map gd to "go do definition"
nnoremap gd :ALEGoToDefinition<CR>

" allow switching of buffers without saving files
" A hidden buffer is a buffer with some unsaved modifications and is not displayed in a window. Hidden buffers are useful, if you want to edit multiple buffers without saving the modifications made to a buffer while loading other buffers.
set hidden

" show a bar on column 80. Going beyond 80 chars per line gets hard to read.
set colorcolumn=80

" use system clipboard
set clipboard+=unnamedplus

" enable deoplete at startup
let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path=1

"
" let's setup ale, i.e. linting and syntax related stuff
let g:ale_enabled = 1
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_insert_leave = 1
" let g:ale_lint_on_save = 0
" let g:ale_lint_on_enter = 0
" Shows the error/warning text right after the line
" let g:ale_virtualtext_cursor = 1
" If typescript linting doesn't work correct or fast enough with tslint, try
" using 'tsserver' instead
" Disable ale for files inside node_modules
let g:ale_pattern_options = {
\   '.*node_modules.*\.js$': {'ale_enabled': 0, 'ale_fixers': []},
\}
let g:ale_linters = { 'javascript': ['eslint'], 'typescript': ['tslint'], 'rust': ['rls'] }
let g:ale_fixers =  { 'javascript': ['prettier'], 'typescript': ['prettier'], 'css': ['prettier'], 'scss': ['prettier'], 'json': ['prettier']  }
let g:ale_fix_on_save = 1
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = ''
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"
let g:ale_completion_enabled = 1

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% cries %s'
" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

" save rust code on file save
let g:rustfmt_autosave = 1

" easymotion leader is <Leader><Leader> by default. Let's change it to
" <leader> only
map <Leader> <Plug>(easymotion-prefix)
" for quickly jumping to words assuming i know the first two characters of the
" word
map s <Plug>(easymotion-s2)

" let's autoclose jsx tags
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx,*.js'

" add 1 space after comment delimiter
let NERDSpaceDelims=1

" Prevent files from being opened in nerdtree pane, if it's in focus
let g:fzf_layout = { 'window': 'let g:launching_fzf = 1 | keepalt topleft 100split enew' }

autocmd FileType nerdtree let t:nerdtree_winnr = bufwinnr('%')
autocmd BufWinEnter * call PreventBuffersInNERDTree()

function! PreventBuffersInNERDTree()
  if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree'
    \ && exists('t:nerdtree_winnr') && bufwinnr('%') == t:nerdtree_winnr
    \ && &buftype == '' && !exists('g:launching_fzf')
    let bufnum = bufnr('%')
    close
    exe 'b ' . bufnum
  endif
  if exists('g:launching_fzf') | unlet g:launching_fzf | endif
endfunction

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" reload files in buffer if changed on file system
set autoread
