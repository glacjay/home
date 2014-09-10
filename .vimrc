set nocompatible

filetype off " required by vundle
set runtimepath+=~/.vim/bundle/vundle
set runtimepath+=~/go/go/misc/vim
call vundle#rc()
Bundle 'gmarik/vundle'
Plugin 'majutsushi/tagbar'
Plugin 'bufexplorer.zip'
Plugin 'cecscope'
Plugin 'fatih/vim-go'
Plugin 'wting/rust.vim'
if !has("win32")
	Plugin 'airblade/vim-gitgutter'
endif
"Plugin 'Smart-Tabs'
"Plugin 'SWIG-syntax'
"Plugin 'slimv.vim'
"Plugin 'c.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic'
filetype plugin indent on " required by vundle

set runtimepath+=$GOROOT/misc/vim
set path+=/usr/local/include

let mapleader=","
let maplocalleader=","
let g:mapleader=","

nmap <leader>w :w!<cr>
nmap <leader>a :wa<cr>
nmap <leader>q :q<cr>
nmap <leader>m :make<cr>
nmap <leader>cd :cd %:p:h<cr>
nnoremap <silent> <leader>l :BufExplorer<CR>
nmap <leader>t2 :set tabstop=2<cr>
nmap <leader>t4 :set tabstop=4<cr>
nmap <leader>t8 :set tabstop=8<cr>
map <leader>s :source ~/.vimrc<cr>
map <leader>e :e! ~/.vimrc<cr>
autocmd! BufWritePost vimrc source ~/.vimrc

nmap j gj
nmap k gk

set listchars=tab:\|-,trail:-
set list
highlight SpecialKey ctermfg=7 guifg=LightGray
highlight NonText ctermfg=7 guifg=LightGray
highlight link GitGutterChange DiffChange
highlight link GitGutterChangeDelete DiffText

" Jumps to the last known position in a file just after opening it.
autocmd! BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif

syntax enable
autocmd BufEnter * :syntax sync fromstart

if v:version >= 703
    set colorcolumn=80
else
    augroup right_margin_bar
        au!
        autocmd BufRead * highlight OverLength ctermbg=lightgreen guibg=lightgreen
        autocmd BufRead * match OverLength /\%80v/
    augroup END
endif

set fileformats=unix,dos,mac
set fileencodings=utf-8,gbk,ucs-bom

set scrolloff=3
set ruler
set number
set lazyredraw
set ignorecase smartcase
set incsearch
set hlsearch
set magic
set noerrorbells
set novisualbell
set t_vb=
set noshowmatch
set laststatus=2
set nobackup
set nowritebackup
set noswapfile
set completeopt=menu,longest,preview
set formatoptions+=Mm
set linebreak
set wrap
set autoread
set hidden " don't need to save when switch buffers
set wildmode=longest,list " emacs-style path completion

function! CurDir()
    let curdir = substitute(getcwd(), '^/home/jay', '~', 'g')
    return curdir
endfunction
set statusline=%F%m%r%h\ %w\ cwd:%r%{CurDir()}%h%=\ Enc:%{&fenc}\ Line:%l/%L:%c\ %P

function! DeleteTrailingWS()
    execute "normal mz"
    %s/\s\+$//ge
    execute "normal `z"
endfunction
"autocmd BufWritePre * :call DeleteTrailingWS()
nmap <leader>d :call DeleteTrailingWS()<cr>

autocmd BufNewFile,BufRead *.i set filetype=swig
autocmd BufNewFile,BufRead *.asd set filetype=lisp

set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smarttab
set autoindent
set cinoptions=u0,U0,g0,W2s,N-s,:0

" TagBar Plugin Settings
nmap <leader>t :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
if has("mac")
	let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif
let g:tagbar_left = 1
let g:tagbar_width = 40
let g:tagbar_sort = 0
let g:tagbar_compact = 1

" Cscope Settings
if has("cscope")
    set nocsverb
    set csto=0
    set cst
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    nmap <C-[>s :cs f s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-[>g :cs f g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-[>c :cs f c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-[>t :cs f t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-[>e :cs f e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-[>f :cs f f <C-R>=expand("<cword>")<CR><CR>
    nmap <C-[>i :cs f i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-[>d :cs f d <C-R>=expand("<cword>")<CR><CR>
endif
