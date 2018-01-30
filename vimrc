source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
if filereadable(expand("$HOME/vimfiles/vimrc.vundle"))
	source $HOME/vimfiles/vimrc.vundle
endif
behave mswin

" Startup {{{
  filetype indent plugin on

" vim 使用 marker 折叠方式
  augroup ft_vim
      au!
      au FileType vim setlocal foldmethod=marker
  augroup END
" 隐藏菜单栏，使用F2切换显示
  set guioptions-=m
  set guioptions-=T
  
  map <silent> <F2> :if &guioptions =~# 'T' <Bar>
  	\set guioptions-=T <Bar>
  	\set guioptions-=m <Bar>
  	\else <Bar>
  	\set guioptions+=m <Bar>
  	\set guioptions+=T <Bar>
  	\endif<CR>
 
" }}}

" file {{{

" 指定缓存文件的存放路径
  set backup
  set backupdir  =$HOME/vimfiles/backup/
  set backupext  =-vimbackup
  set backupskip =
  set directory  =$HOME/vimfiles/swap/
  set updatecount=100
  set undofile
  set undodir    =$HOME/vimfiles/undo/
  set viminfo    ='100,<500,n$HOME/vimfiles/viminfo

" }}}

" font {{{
 set guifont=Consolas_for_Powerline_FixedD:h12
" }}}

" General {{{

  set number					" 设置行号
  set cursorline				" ͻ????ʾ??ǰ??
" set cursorcolumn				" ͻ????ʾ??ǰ??
  set tabstop=4					" ????
  colorscheme solarized			" Gvim配色
  set background=dark
  syntax on 

" }}}

" 编码设置 {{{

" Vim 在与屏幕/键盘交互时使用的编码
  set encoding=utf-8
  set langmenu=zh_CN.UTF-8
" 设置打开文件的编码格式
  set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" set fileencoding=utf-8
" 解决菜单乱码
  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
" 设置为双字宽显示
  set ambiwidth=double

" }}}

" map {{{

  nmap <C-S> :source $home/vimfiles/vimrc<CR>

" }}}

" airline {{{

" 设置状态栏永远显示
  set laststatus=2
" 主题
  let g:airline_theme="solarized"
" 打开tabline功能,方便查看Buffer和切换
  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#buffer_nr_show=1
" 关闭空白符检测
  let g:airline#extensions#whitespace#enabled=0
" 设置airline字体
  let g:airline_powerline_fonts=1
  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  let g:airline_left_sep = '⮀'
  let g:airline_left_alt_sep = '⮁'
  let g:airline_right_sep = '⮂'
  let g:airline_right_alt_sep = '⮃'
  let g:airline_symbols.branch = '⭠'
  let g:airline_symbols.readonly = '⭤'
  let g:airline_symbols.linenr = '⭡'
" 设置buffer切换快捷键
"nnoremap <C-N> :bn<CR>
"nnoremap <C-P> :bp<CR>

" }}}

" MyDiff {{{
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
" }}}
