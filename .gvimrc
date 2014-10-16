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

set columns=90      "�E�B���h�E�̕�
set lines=48        "�E�B���h�E�̍���

set number

"�c�[���o�[���\��
set guioptions-=T
"���j���[�o�[���\���ɂ���
"set guioptions-=m

"���E�̃X�N���[���o�[���\���ɂ���
set guioptions-=r
"set guioptions-=R
set guioptions-=l
"set guioptions-=L
"�����X�N���[���o�[���\���ɂ���
set guioptions-=b

"����
gui
set transparency=230
"�Ȃɂ������c

" IME�̏�Ԃ��J���[�\��
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

""""""""""""""""""""""""""""""
"Window�ʒu�̕ۑ��ƕ��A
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

"�N���b�v�{�[�h��Windows�ƘA�g����
set clipboard=unnamed

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"��":""}',
      \ },
      \ 'separator': { 'left': '��', 'right': '��' },
      \ 'subseparator': { 'left': '��', 'right': '��' }
      \ }
