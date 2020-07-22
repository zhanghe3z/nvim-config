
set nocompatible
source $VIMRUNTIME/mswin.vim
behave mswin


source $VIMRUNTIME/delmenu.vim 
source $VIMRUNTIME/menu.vim



au GUIEnter * simalt ~x

noremap j h
noremap i k
noremap k j
noremap I 5k
noremap K 5j
noremap h i
noremap H I

let mapleader=","
map <c-w>h :sp<CR>
map <c-w>v :vsp<CR>
map s <nop>
map Q :q<CR>
map R :source $MYVIMRC <CR> 
nnoremap <c-j> :AnyJump<CR>
noremap <c-w>j  <c-w>h 
noremap <c-w>i  <c-w>k
noremap <c-w>k  <c-w>j  

let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9
let g:nrrw_rgn_nomap_nr = 1
let g:nrrw_rgn_nomap_Nr = 1

set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
set mouse=a
noremap <LEADER><CR> :nohlsearch <CR>
noremap = nzz


set number
syntax on
set cursorline
set wrap
set showcmd
set wildmenu
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set cindent
set history=1000 
autocmd BufEnter * silent! lcd %:p:h

" Call figlet
map tx :r !figlet 

" Compile function
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    set splitbelow
    exec "!g++ -std=c++11 % -Wall -o %<"
    :sp
    :res -15
    :term ./%<
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitbelow
    :sp
    :term python3 %
  elseif &filetype == 'html'  
    silent! exec "!chromium % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'tex'
    silent! exec "VimtexStop"
    silent! exec "VimtexCompile"
  elseif &filetype == 'go'
    set splitbelow
    :sp
    :term go run %
  endif
endfunc




set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
if executable("vimtweak.dll") 
autocmd guienter * call libcallnr("vimtweak","SetAlpha",222) 
endif 
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

call plug#begin('~/.vim/plugged')
Plug 'gmarik/Vundle.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'vim-latex/vim-latex'
Plug 'airblade/vim-gitgutter'
Plug 'mindriot101/vim-yapf'
Plug 'liuchengxu/space-vim-theme'
Plug 'airblade/vim-rooter'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'pechorin/any-jump.vim'
Plug 'SirVer/ultisnips'
Plug 'vim-python/python-syntax'
"Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
Plug 'zhanghe3z/vim-snippets'
Plug 'powerline/powerline'
Plug 'preservim/nerdcommenter'
call plug#end()


" ===
" === YCM
" ===

let g:ycm_complete_in_comments = 1


" ===
" === Window behaviors
" ===
set splitright
set splitbelow

" ===
" === My Snippets
" ===
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<i>"
let g:UltiSnipsJumpBackwardTrigger="<k>"


" ===
" === Dress up my vim
" ===
set termguicolors     " enable true colors support
let g:space_vim_transp_bg = 1
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesOdd  ctermbg=darkgrey
hi IndentGuidesEven ctermbg=grey
colorscheme space_vim_theme

" ===
" === rnvimr
" ===
"noremap <c-r> :RnvimrToggle<CR>
"let g:rnvimr_enable_ex = 1
"let g:rnvimr_draw_border = 0
"let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"
"            \ --cmd="set draw_borders both"'
"let g:rnvimr_enable_bw = 1
"let g:rnvimr_layout = { 'relative': 'editor',
"            \ 'width': float2nr(round(0.6 * &columns)),
"            \ 'height': float2nr(round(0.6 * &lines)),
"            \ 'col': float2nr(round(0.2 * &columns)),
"            \ 'row': float2nr(round(0.2 * &lines)),
"            \ 'style': 'minimal' 





" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1
" let g:python_slow_sync = 0


" ===
" === Other useful stuff
" ===
autocmd BufEnter * silent! lcd %:p:h
nnoremap <c-c> "+yy
nnoremap <c-v> "+p



" ===
" === Airline
" ===
"let g:airline_theme='dracula'
"let g:airline#extensions#coc#enabled = 0
"let g:airline#extensions#branch#enabled = 0
"let g:airline#extensions#tabline#enabled = 0
"let g:airline#extensions#tabline#formatter = 'unique_tail'
"let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#show_buffers = 0
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_mode_map = {
      "\ '__' : '-',
      "\ 'n'  : 'Nor',
      "\ 'i'  : 'Ins',
      "\ 'R'  : 'Rpl',
      "\ 'c'  : 'Cmd',
      "\ 'v'  : 'Vis',
      "\ 'V'  : 'Vli',
      "\ '' : 'Vbl',
      "\ 's'  : 'S',
      "\ 'S'  : 'S',
      "\ '' : 'S',
      "\ }

let g:airline_powerline_fonts = 0



if executable("vimtweak.dll") 
	autocmd guienter * call libcallnr("vimtweak","SetAlpha",222) 
endif 

