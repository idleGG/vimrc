""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"默认设置"
set nocompatible
"source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

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
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 习惯设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 最大化运行
if has("win32")
 au GUIEnter * simalt ~x
endif

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11

set nobackup		" do not keep a backup file

let mapleader = ';'			" 用;作为命令前缀

"set guioptions=egmrLtT     " 默认选项
set guioptions+=c       " 使用字符提示框
set guioptions-=m       " 隐藏菜单栏
set guioptions-=g       " 灰色菜单
set guioptions-=T       " 隐藏工具栏
set guioptions-=L       " 隐藏左侧滚动条
set guioptions-=r       " 隐藏右侧滚动条
set guioptions-=l       " 隐藏左侧滚动条
set guioptions-=b       " 隐藏底部滚动条
"set showtabline=0      " 隐藏Tab栏
set cursorline          " 高亮显示当前行

" 显示行号
set nu!
set relativenumber

" 自动缩进
set autoindent
set cindent

" 语法高亮显示
syntax enable
syntax on
colorscheme desert			" 配色方案

" Tab键的宽度
set tabstop=4
" 统一缩进为4
if has("autocmd") 
autocmd FileType java,mkd,c,cpp,vim set expandtab	"对指定文件类型，使用空格代替tab
endif "has("autocmd")

set softtabstop=4
set shiftwidth=4
" 设置TAB和行尾空格的显示
"set list
"set listchars=tab:>-,trail:-

" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 为C程序提供自动缩进
set smartindent
" 搜索忽略大小写
"set ignorecase
" 搜索逐字符高亮
set hlsearch
" 在行和段开始处使用制表符
"set smarttab
" 历史记录数
set history=1000
" 编码设置
"set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" 语言设置
"set langmenu=zh_CN.UTF-8
set langmenu=zh_CN.GBK
set helplang=cn

" 状态行显示的内容（包括文件类型和解码）
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 括号自动补全
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>

:inoremap " <c-r>=QuoteDelim('"')<CR>
:inoremap ' <c-r>=QuoteDelim("'")<CR>

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alt+[n] 切换tab"
:nn <M-1> 1gt
:nn <M-2> 2gt
:nn <M-3> 3gt
:nn <M-4> 4gt
:nn <M-5> 5gt
:nn <M-6> 6gt
:nn <M-7> 7gt
:nn <M-8> 8gt
:nn <M-9> 9gt
:nn <M-0> :tablast<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ctags
set tags=tags
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" WinManager
let g:winManagerWindowLayout='FileExplorer|TagList'
"let g:winManagerWindowLayout='FileExplorer'
nmap wm :WMToggle<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Cscope 设定是否使用 quickfix 窗口来显示 cscope 结果
:set cscopequickfix=s-,c-,d-,i-,t-,e-
:cs add .\cscope.out
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" MiniBufExplorer 快速浏览和操作Buffer
"let g:miniBufExplMapCTabSwitchBufs = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" a.vim	使用Ctrl+a快速切换.c\.h文件
map <C-A> :A <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" OmniCppComplete 自动补全
filetype plugin indent on		"打开文件类型检测
set completeopt=longest,menu
let OmniCpp_DefaultNamespaces = ["std","MyNamespace"]
let OmniCpp_ShowPrototypeInAbbr = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" supertab
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Powerline设置
set laststatus=2
let g:Powerline_symbols='unicode'

" 对NERD_commenter的设置
let NERDShutUp=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DoxygenToolkit
map   fg   :Dox < cr >
let  g:DoxygenToolkit_authorName = "LiuFG"
let  g:DoxygenToolkit_CopyrightString = "Beijing JN TASS Technology Co.,Ltd."
let  g:DoxygenToolkit_licenseTag = "My own license\<enter>"
let  g:DoxygenToolkit_undocTag = "LiuFG SKIP_BLOCK"
let  g:DoxygenToolkit_briefTag_pre   =   "@brief\t"
let  g:DoxygenToolkit_paramTag_pre   =   "@param\t"
let  g:DoxygenToolkit_returnTag   =   "@return\t"
let  g:DoxygenToolkit_briefTag_funcName   =   "no"
let  g:DoxygenToolkit_maxFunctionProtoLines   =   30


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按键映射/说明
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F12刷新tags
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> cscope -Rbq <CR>
" Ctrl-]    跳转到光标所在符号的定义
" Ctrl-t    回到上次跳转前的位置。
"
" F3 NERDTree切换
let NERDTreeWinPos=1
map <F3> :NERDTreeToggle<CR>

" F2 TagList切换
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
map <F2> :Tlist<CR>

au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=mkd
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_folding_level = 6
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_emphasis_multiline = 0
set conceallevel=2

" Vundle配置
filetype off

"此处规定Vundle的路径
set rtp+=d:/Tools/Vim/vimfiles/Vundle.vim

call vundle#begin()

"Vundle插件管理
Bundle 'gmarik/vundle'
"Tlist
Bundle 'taglist.vim'
"Doxy
Bundle 'DoxygenToolkit.vim'
"注释工具
Bundle 'The-NERD-Commenter'
"文件浏览
Bundle 'The-NERD-tree'
"代码补全
Bundle 'OmniCppComplete'
"状态栏
Bundle 'Lokaltog/vim-powerline'
"C语言源文件于头文件快速切换
Bundle 'a.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"此行前添加要安装的插件列表
call vundle#end()
filetype plugin indent on


