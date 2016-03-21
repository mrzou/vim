runtime! debian.vim

filetype plugin indent on
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set langmenu=zh_CN.UTF-8    
language message zh_CN.UTF-8
set helplang=cn   	 
"set cursorline "高亮当前行
set ai
set nu
set ru
set expandtab
set tabstop=2
set shiftwidth=2
set guioptions-=m
set guioptions-=T  
set ignorecase 	"搜索不区分大小写
set foldopen=all
set hlsearch    	"高亮显示搜索
set incsearch    	"定位显示搜索字符
set pastetoggle=<F9> "粘贴代码混乱
" 设置工作目录为当前编辑文件的目录
set bsdir=buffer
set autochdir

" 按tab键自动补全功能键的配置begin
fu! InsertTabWrapper()
    let col=col('.')-1
    return (!col || getline('.')[col-1] !~ '\k') ? "\<TAB>" : "\<C-P>"
endf
ino <TAB> <C-R>=InsertTabWrapper()<CR>
ino <S-TAB> <C-R>="\<TAB>"<CR>
" 按tab键自动补全功能键的配置end

:inoremap ( ()<ESC>i
:inoremap { {  }<ESC>i<LEFT>
:inoremap [ []<ESC>i
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i
:inoremap < <><ESC>i
" 插入模式中按ctrl+k匹配<%= %>
" 插入模式中按ctrl+i匹配<% %>
" 插入模式中按ctrl+b匹配binding.pry
:inoremap <C-K> <%=  %><LEFT><Esc>i
:inoremap <C-i> <%  %><LEFT><Esc>i<LEFT>
:inoremap <C-b> binding.pry

set guifont=Menlo:h12
"set guifont=Bitstream_Vera_Sans_Mono:h25:cANSI

" 设置窗口的大小
" set lines=44 columns=108

" 在normal 模式下在单词中加{  }和“”，双击相应的按键
" ctrl+h是切换到左边的标签，ctrl+l切换到右边的标签
" ctrl+p搜索该项目下的文件
" ctrl+f打开文件的树目录
" ctrl+f打开nerdtree
:map {{ i <Esc>r{ea}<Esc>
:map "" i <Esc>r"ea"<Esc>x
:map <C-h> gT
:map <C-l> gt
:map <D-j> :CtrlP<CR>
:map <D-e> :NERDTreeToggle<CR>
nmap <f2> :NERDTreeToggle<cr>

" vundle的配置
set nocompatible                " be iMproved
"filetype off                    " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" my bundle
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-endwise'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'altercation/vim-colors-solarized'

" NERD treelet NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
"autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" 修改ctrap默认搜索方式
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" 状态条的显示依次为当前模式.git分支.文件路径.文件是否保存以及当前所载行和列的信息
set laststatus=2 " Always display the status line
set statusline+=%{fugitive#statusline()} "  Git Hotness

" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"javascript高亮显示
syntax enable " enable syntax hightlight and completion
syntax on " syntax highlighing
filetype on " try to detect file types

" vim-colors-solarized 配置
syntax enable
set background=dark
"set background=light
colorscheme solarized
