"space bar as leader key
let mapleader = "\<Space>"

"show command
set showcmd

"syntax coloring
filetype plugin indent on
syntax on

"global clipboard-no registries
set clipboard=unnamedplus

"incremental search
set incsearch

"case-sensitive search if it contains an uppercase char
set ignorecase
set smartcase

"undo!
set undofile
set undodir=~/.vim/undo-dir

"cursor
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_SR = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
else
    let &t_SI = "\<Esc>[5 q"
    let &t_SR = "\<Esc>]5 q"
    let &t_EI = "\<Esc>]2 q"
endif

"xstatus bar
set laststatus=2

"show numbers
set number

"dark background (needed inside tmux)
set background=dark

"paste toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"install vimplug
if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

"install plugins
call plug#begin('~/.vim/plugged')

"lightline (status line)
Plug 'itchyny/lightline.vim'
let g:lightline = {
\ 'colorscheme': 'seoul256',
\}

"fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

"ale
Plug 'dense-analysis/ale'
let g:ale_linter = {
\  'python': ['black', 'flake8'],
\  'javascript': ['eslint'],
\}
let g:ale_sign_column_always = 1

"tcomment
Plug 'tomtom/tcomment_vim'

"vimwiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"instant markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
let g:instant_markdown_autostart = 0

call plug#end()

"fzf mappings
nmap <Leader>t :Files<CR>
nmap <Leader>r :History:<CR>
nmap <Leader>s :History/<CR>
