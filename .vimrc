" my confing
set runtimepath^=~/vimfiles
"set runtimepath^=~/vimfiles/colors

syntax on
set background=dark
set autochdir

set number
set cursorline
hi clear CursorLine

"set encoding=utf-8
"set fileencodings=utf-8,latin1
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin

" バックアップ取らない
set nobackup
" 他で書き換えられたら自動で読み直す
"set autoread
" スワップファイル作らない
set noswapfile
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

" status line
set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
"highlight statusline   term=NONE cterm=NONE guifg=green ctermfg=black ctermbg=green
"highlight StatusLine term=bold cterm=bold ctermfg=black ctermbg=white

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

"nnoremap <silent>bp :bprevious<CR>
"nnoremap <silent>bn :bnext<CR>
"nnoremap <silent>bb :b#<CR>

" netrwは常にtree view
let g:netrw_liststyle = 3
" CVSと.で始まるファイルは表示しない
"let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

" SKK
let skk_jisyo = '~/.skk-jisyo'
let skk_large_jisyo = '~/.emacs.d/SKK-JISYO.L'
let skk_auto_save_jisyo = 1
let skk_keep_state =0
let skk_egg_like_newline = 1
let skk_show_annotation = 1
let skk_use_face = 1

let &statusline .= '%{SkkGetModeStr()}'

" Neobundle
set runtimepath+=~/vimfiles/bundle/neobundle.vim/
" Required:
call neobundle#begin(expand('~/vimfiles/bundle/'))
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tacroe/unite-mark'
"
NeoBundle 'itchyny/lightline.vim'
call neobundle#end()

NeoBundleCheck

" Required:
filetype plugin indent on

" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <silent> Ub :Unite buffer<CR>
" ファイル一覧
noremap <silent> Uf :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <silent> Um :Unite file_mru<CR>
" ブックマーク一覧
noremap <silent> Uc :<C-u>Unite bookmark<CR>
"ブックマークに追加
noremap <silent> Ua :<C-u>UnitebookmarkAdd<CR>

" encoding
nmap <silent> eu :set fenc=utf-8<CR>
nmap <silent> ee :set fenc=euc-jp<CR>
nmap <silent> es :set fenc=cp932<CR>
" encode reopen encoding
nmap <silent> eru :e ++enc=utf-8 %<CR>
nmap <silent> ere :e ++enc=euc-jp %<CR>
nmap <silent> ers :e ++enc=cp932 %<CR>
