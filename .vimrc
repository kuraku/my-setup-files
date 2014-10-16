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

" �o�b�N�A�b�v���Ȃ�
set nobackup
" ���ŏ���������ꂽ�玩���œǂݒ���
"set autoread
" �X���b�v�t�@�C�����Ȃ�
set noswapfile
" �ۑ�����tab���X�y�[�X�ɕϊ�����
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

" netrw�͏��tree view
let g:netrw_liststyle = 3
" CVS��.�Ŏn�܂�t�@�C���͕\�����Ȃ�
"let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'�Ńt�@�C�����J���Ƃ��͉E���ɊJ���B(�f�t�H���g�������Ȃ̂œ���ւ�)
let g:netrw_altv = 1
" 'o'�Ńt�@�C�����J���Ƃ��͉����ɊJ���B(�f�t�H���g���㑤�Ȃ̂œ���ւ�)
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
" neobundle���̂�neobundle�ŊǗ�
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

" ���̓��[�h�ŊJ�n����
let g:unite_enable_start_insert=1
" �o�b�t�@�ꗗ
noremap <silent> Ub :Unite buffer<CR>
" �t�@�C���ꗗ
noremap <silent> Uf :Unite -buffer-name=file file<CR>
" �ŋߎg�����t�@�C���̈ꗗ
noremap <silent> Um :Unite file_mru<CR>
" �u�b�N�}�[�N�ꗗ
noremap <silent> Uc :<C-u>Unite bookmark<CR>
"�u�b�N�}�[�N�ɒǉ�
noremap <silent> Ua :<C-u>UnitebookmarkAdd<CR>

" encoding
nmap <silent> eu :set fenc=utf-8<CR>
nmap <silent> ee :set fenc=euc-jp<CR>
nmap <silent> es :set fenc=cp932<CR>
" encode reopen encoding
nmap <silent> eru :e ++enc=utf-8 %<CR>
nmap <silent> ere :e ++enc=euc-jp %<CR>
nmap <silent> ers :e ++enc=cp932 %<CR>
