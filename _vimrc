""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Ĭ������"
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
" ϰ������
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �������
if has("win32")
 au GUIEnter * simalt ~x
endif

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11

set nobackup		" do not keep a backup file

let mapleader = ';'			" ��;��Ϊ����ǰ׺

"set guioptions=egmrLtT     " Ĭ��ѡ��
set guioptions+=c       " ʹ���ַ���ʾ��
set guioptions-=m       " ���ز˵���
set guioptions-=g       " ��ɫ�˵�
set guioptions-=T       " ���ع�����
set guioptions-=L       " ������������
set guioptions-=r       " �����Ҳ������
set guioptions-=l       " ������������
set guioptions-=b       " ���صײ�������
"set showtabline=0      " ����Tab��
set cursorline          " ������ʾ��ǰ��

" ��ʾ�к�
set nu!
set relativenumber

" �Զ�����
set autoindent
set cindent

" �﷨������ʾ
syntax enable
syntax on
colorscheme desert			" ��ɫ����

" Tab���Ŀ��
set tabstop=4
" ͳһ����Ϊ4
if has("autocmd") 
autocmd FileType java,mkd,c,cpp,vim set expandtab	"��ָ���ļ����ͣ�ʹ�ÿո����tab
endif "has("autocmd")

set softtabstop=4
set shiftwidth=4
" ����TAB����β�ո����ʾ
"set list
"set listchars=tab:>-,trail:-

" ͨ��ʹ��: commands������������ļ�����һ�б��ı��
set report=0
" ΪC�����ṩ�Զ�����
set smartindent
" �������Դ�Сд
"set ignorecase
" �������ַ�����
set hlsearch
" ���кͶο�ʼ��ʹ���Ʊ��
"set smarttab
" ��ʷ��¼��
set history=1000
" ��������
"set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
" ��������
"set langmenu=zh_CN.UTF-8
set langmenu=zh_CN.GBK
set helplang=cn

" ״̬����ʾ�����ݣ������ļ����ͺͽ��룩
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" �����Զ���ȫ
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
" Alt+[n] �л�tab"
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
" �������
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

" Cscope �趨�Ƿ�ʹ�� quickfix ��������ʾ cscope ���
:set cscopequickfix=s-,c-,d-,i-,t-,e-
:cs add .\cscope.out
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" MiniBufExplorer ��������Ͳ���Buffer
"let g:miniBufExplMapCTabSwitchBufs = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" a.vim	ʹ��Ctrl+a�����л�.c\.h�ļ�
map <C-A> :A <CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" OmniCppComplete �Զ���ȫ
filetype plugin indent on		"���ļ����ͼ��
set completeopt=longest,menu
let OmniCpp_DefaultNamespaces = ["std","MyNamespace"]
let OmniCpp_ShowPrototypeInAbbr = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" supertab
"let g:SuperTabRetainCompletionType=2
"let g:SuperTabDefaultCompletionType="<C-X><C-O>"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Powerline����
set laststatus=2
let g:Powerline_symbols='unicode'

" ��NERD_commenter������
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
" ����ӳ��/˵��
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" F12ˢ��tags
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> cscope -Rbq <CR>
" Ctrl-]    ��ת��������ڷ��ŵĶ���
" Ctrl-t    �ص��ϴ���תǰ��λ�á�
"
" F3 NERDTree�л�
let NERDTreeWinPos=1
map <F3> :NERDTreeToggle<CR>

" F2 TagList�л�
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

" Vundle����
filetype off

"�˴��涨Vundle��·��
set rtp+=d:/Tools/Vim/vimfiles/Vundle.vim

call vundle#begin()

"Vundle�������
Bundle 'gmarik/vundle'
"Tlist
Bundle 'taglist.vim'
"Doxy
Bundle 'DoxygenToolkit.vim'
"ע�͹���
Bundle 'The-NERD-Commenter'
"�ļ����
Bundle 'The-NERD-tree'
"���벹ȫ
Bundle 'OmniCppComplete'
"״̬��
Bundle 'Lokaltog/vim-powerline'
"C����Դ�ļ���ͷ�ļ������л�
Bundle 'a.vim'

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"����ǰ���Ҫ��װ�Ĳ���б�
call vundle#end()
filetype plugin indent on


