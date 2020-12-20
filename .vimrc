set encoding=utf-8
set exrc
set noswapfile

set nocompatible
filetype off

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
Plugin '2dev2fun/color_coded'
Plugin 'morhetz/gruvbox'
Plugin 'preservim/nerdtree'
Plugin 'preservim/nerdcommenter'
Plugin 'vim-airline/vim-airline'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tikhomirov/vim-glsl'
Plugin 'sheerun/vim-polyglot'
Plugin 'pboettch/vim-cmake-syntax'

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

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>( viw<esc>a)<esc>bi(<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel

inoremap jk <esc>

"------------------------------------------------------------------------------
" Abbreviations
"------------------------------------------------------------------------------

iabbrev @@ 2def2fun@gmail.com
iabbrev ccopy Copyright 2020 Maxim 2Dev2Fun, all rights reserved.

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
	exec "wincmd ".a:key
	if(t:curwin==winnr())
		if(match(a:key, '[jk]'))
			wincmd v
		else
			wincmd s
		endif
		exec "wincmd ".a:key
	endif
endfunction

"------------------------------------------------------------------------------
" Clang-format
"------------------------------------------------------------------------------

autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

nmap <Leader>C :ClangFormatAutoToggle<CR>

"------------------------------------------------------------------------------
" YouCompleteMe
"------------------------------------------------------------------------------

nnoremap <leader>go :YcmCompleter GoTo<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>
nnoremap <leader>gd :YcmCompleter GetDoc<CR>
nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gp :YcmCompleter GetParent<CR>
nnoremap <leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>yd :YcmDiags<CR>
nnoremap <leader>dc <plug>(YCMHover)

set updatetime=100000

let g:ycm_clangd_args=['--header-insertion=never']
let g:ycm_confirm_extra_conf=0
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_autoclose_preview_window_after_insertion=0
let g:ycm_add_preview_to_completeopt=0
set completeopt-=preview

"------------------------------------------------------------------------------
" Vim-cpp-enhanced-highlight
"------------------------------------------------------------------------------

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

"------------------------------------------------------------------------------
" vim-python/python-syntax
"------------------------------------------------------------------------------

let g:python_highlight_all = 1

"-------------------------------------------------------------------------------
" clang-rename
"-------------------------------------------------------------------------------

let g:clang_rename_path="clang-rename"
nnoremap <leader>cr :py3f ~/.vim/bundle/SimpleVim/clang-rename.py<cr>
