set encoding=utf-8
set exrc
set noswapfile

set nocompatible
filetype off

"------------------------------------------------------------------------------
" Path
"------------------------------------------------------------------------------

if has("win32")
	set path+=C:\Soft\mingw-w64\mingw64\lib\gcc\x86_64-w64-mingw32\8.1.0\include\c++
elseif has("unix")
	set path+=/usr/include/c++/7
endif

"------------------------------------------------------------------------------
" Disable gui menu and toolbar
"------------------------------------------------------------------------------

if has("gui_running")
	set guioptions-=T
	set guioptions-=m
endif

if has("gui")
	if has("win32")
		au GUIEnter * simalt ~x
	elseif has("gui_gtk2")
		au GUIEnter * :set lines=99999 columns=99999
	endif
endif

"------------------------------------------------------------------------------
" Font
"------------------------------------------------------------------------------

if has("gui_running")
	 if has("gui_gtk2")
		set guifont=Inconsolata\ 12
	elseif has("gui_macvim")
		set guifont=Menlo\ Regular:h14
	elseif has("gui_win32")
		 set guifont=Consolas:h11:cANSI
	endif
endif

"------------------------------------------------------------------------------
" Vundle
"------------------------------------------------------------------------------

if has("win32")
	set rtp+=$HOME\vimfiles\bundle\Vundle.vim
	call vundle#begin('$HOME\vimfiles\bundle')
elseif has("unix")
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

Plugin 'VundleVim/Vundle.vim'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tikhomirov/vim-glsl'

call vundle#end()
filetype plugin indent on

"------------------------------------------------------------------------------

autocmd! BufNewFile,BufRead *.vs,*.fs,*.gs set ft=glsl

set hlsearch
set incsearch

set autoread

colorscheme gruvbox
set background=dark

set list
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:.

set number
set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab

set syntax=on
set mouse=a
syntax on

set wildmode=longest,list

autocmd BufWinLeave * call clearmatches()

"------------------------------------------------------------------------------
" Mapping
"------------------------------------------------------------------------------

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set backspace=indent,eol,start

let mapleader=","

"------------------------------------------------------------------------------
" NerdTree
"------------------------------------------------------------------------------

map <C-n> :NERDTreeToggle<CR>

map<Leader> <Plug>(easymotion-prefix)

map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

function! WinMove(key)
	let t:curwin=winnr()
	exec "wincmd " a:key
	if(t:curwin=winnr())
		if(match(a:key, '[jk]'))
			wimcmd v
		else
			wincmd s
		endif
		exec "wincmd " a:key
	endif
endfunction

"------------------------------------------------------------------------------
" NerdTree
"------------------------------------------------------------------------------

nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jk :YcmCompleter GoToDefinition<CR>

" Load ycm conf by default
let g:ycm_confirm_extra_conf=0

" Only show completion as a list instead of sub-window
let g:ycm_add_preview_to_completeopt=0
set completeopt-=preview

" Start completion from the first character
let g:ycm_min_num_of_chars_for_completion=1

"------------------------------------------------------------------------------
" Vim-cpp-enhanced-highlight
"------------------------------------------------------------------------------

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
