set go= 
"设置配色，这里选择的是desert，也有其他方案，在vim中输入:color 在敲tab键可以查看 
"设置背景色，每种配色有两种方案，一个light、一个dark 
set background=light 
"打开语法高亮	
syntax on 
"显示行号 
set number 
"设置缩进有三个取值cindent(c风格)、smartindent(智能模式，其实不觉得有什么智能)、autoindent(简单的与上一行保持一致) 
set cindent 
"在windows版本中vim的退格键模式默认与vi兼容，与我们的使用习惯不太符合，下边这条可以改过来
set backspace=indent,eol,start 
"用空格键替换制表符 
:set expandtab 
"制表符占4个空格 
set tabstop=4 
"默认缩进4个空格大小 
set shiftwidth=4 
"增量式搜索 
set incsearch 
"高亮搜索 
set hlsearch 
"有时中文会显示乱码，用一下几条命令解决 
let &termencoding=&encoding 
" 设置编码
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
"很多插件都会要求的配置检测文件类型 
:filetype on 
:filetype plugin on 
:filetype indent on 
"下边这个很有用可以根据不同的文件类型执行不同的命令 
"例如：如果是c/c++类型 
:autocmd FileType c,cpp : set foldmethod=syntax 
:autocmd FileType c,cpp : set foldlevel=99 
:autocmd FileType c,cpp :set number 
:autocmd FileType c,cpp :set cindent 
"例如：如果是python类型 
:autocmd FileType python :set number 
:autocmd FileType python : set foldmethod=syntax 
:autocmd FileType python :set smartindent


"/* 当新建 .h .c .hpp .cpp 等文件时自动调用SetTitle 函数*/
autocmd BufNewFile *.[ch],*.hpp,*.cpp exec ":call SetTitle()" 

"/* 加入注释 */
func SetComment()
    call setline(1,"/*==================================") 
    call append(line("."),   "*   Copyright (C) ".strftime("%Y")." All rights reserved.")
    call append(line(".")+1, "*   ") 
    call append(line(".")+2, "*   文件名称：".expand("%:t")) 
    call append(line(".")+3, "*   创 建 者：moon")
    call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日")) 
    call append(line(".")+5, "*   描    述：") 
    call append(line(".")+6, "*")
    call append(line(".")+7, "================================================================*/") 
endfunc

"/* 定义函数SetTitle，自动插入文件头 */
func SetTitle()
    call SetComment()
    if expand("%:e") == 'hpp' 
        call append(line(".")+8, "#ifndef _".toupper(expand("%:t:r"))."_H") 
        call append(line(".")+9, "#define _".toupper(expand("%:t:r"))."_H") 
        call append(line(".")+10, "#ifdef __cplusplus") 
        call append(line(".")+11, "extern \"C\"") 
        call append(line(".")+12, "{") 
        call append(line(".")+13, "#endif") 
        call append(line(".")+14, "") 
        call append(line(".")+15, "#ifdef __cplusplus") 
        call append(line(".")+16, "}") 
        call append(line(".")+17, "#endif") 
        call append(line(".")+18, "#endif //".toupper(expand("%:t:r"))."_H") 
    elseif expand("%:e") == 'h' 
        call append(line(".")+8, "#pragma once") 
    elseif &filetype == 'c' 
        "call append(line(".")+8,"#include \"".expand("%:t:r").".h\"") 
    elseif &filetype == 'cpp' 
        "call append(line(".")+8, "#include \"".expand("%:t:r").".h\"") 
    endif
endfunc



function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" 文本格式和排版 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" " 自动格式化 
 set formatoptions=tcrqn 
"
" " 继承前一行的缩进方式，特别适用于多行注释 
" set autoindent 
"
" " 为C程序提供自动缩进 
 set smartindent 
"
" " 使用C样式的缩进 
 set cindent 
"
" " 制表符为4 
 set tabstop=4 
"
" " 统一缩进为4 
 set softtabstop=4 
 set shiftwidth=4 
"
" " 不要用空格代替制表符 
 set noexpandtab 
"
" " 不要换行 
 set nowrap 
"
" " 在行和段开始处使用制表符 
 set smarttab
nmap <silent> <C-q> <esc>:wq<cr> 
nmap <silent> <F5> :!./a.out<cr> 
nmap <silent> mm <esc>:WMToggle<cr> 
"在进入vim时自动打开winmanager 
let g:AutoOpenWinManager=1
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap <silent>  mk :make <cr>
nmap <silent>  ms :w <cr>
nmap <silent>  mc :make clean <cr>
nmap <C-r> :!gcc % <cr>
nmap me :cw <cr>
nmap mq :wq <cr>

map <F9> :w<Esc><CR>:!gcc % -o %:r <CR>
map <F10> :!./%:r<CR>

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
