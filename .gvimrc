" gvimrc my confing
cd $HOME

scriptencoding cp932

set background=dark
"colorscheme hybrid
"colorscheme monokai
"colorscheme murphy
"colorscheme torte
colorscheme wombat
set guifont=M+2VM+IPAG_circle:h10:cSHIFTJIS

set columns=90      "ウィンドウの幅
set lines=48        "ウィンドウの高さ

set number

"ツールバーを非表示
set guioptions-=T
"メニューバーを非表示にする
"set guioptions-=m

"左右のスクロールバーを非表示にする
set guioptions-=r
"set guioptions-=R
set guioptions-=l
"set guioptions-=L
"水平スクロールバーを非表示にする
set guioptions-=b

"透過
gui
set transparency=230
"なにか足らん…

" IMEの状態をカラー表示
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

""""""""""""""""""""""""""""""
"Window位置の保存と復帰
""""""""""""""""""""""""""""""
if has('unix')
  let s:infofile = '~/.vim/.vimpos'
else
  let s:infofile = '~/_vimpos'
endif

function! s:SaveWindowParam(filename)
  redir => pos
  exec 'winpos'
  redir END
  let pos = matchstr(pos, 'X[-0-9 ]\+,\s*Y[-0-9 ]\+$')
  let file = expand(a:filename)
  let str = []
  let cmd = 'winpos '.substitute(pos, '[^-0-9 ]', '', 'g')
  cal add(str, cmd)
  let l = &lines
  let c = &columns
  cal add(str, 'set lines='. l.' columns='. c)
  silent! let ostr = readfile(file)
  if str != ostr
    call writefile(str, file)
  endif
endfunction

augroup SaveWindowParam
  autocmd!
  execute 'autocmd SaveWindowParam VimLeave * call s:SaveWindowParam("'.s:infofile.'")'
augroup END

if filereadable(expand(s:infofile))
  execute 'source '.s:infofile
endif
unlet s:infofile

" Don't exit vim when closing last tab with :q and :wq, :qa, :wqa
cabbrev q   <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 && tabpagenr('$') == 1 && winnr('$') == 1 ? 'enew' : 'q')<CR>
cabbrev wq  <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 && tabpagenr('$') == 1 && winnr('$') == 1 ? 'w\|enew' : 'wq')<CR>
cabbrev qa  <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'tabonly\|only\|enew' : 'qa')<CR>
cabbrev wqa <C-r>=(getcmdtype() == ':' && getcmdpos() == 1 ? 'wa\|tabonly\|only\|enew' : 'wqa')<CR>

" highlight
"hi Cursor guifg=black guibg=green
"hi CursorIM   guifg=NONE guibg=Red
"hi CursorLine guifg=NONE guibg=#505050
"hi TabLineSel guibg=Red
"hi CursorLine gui=underline

"クリップボードをWindowsと連携する
set clipboard=unnamed

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
