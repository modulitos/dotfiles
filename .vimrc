imap jj <Esc>
syntax on
" run C-@ to send the vim clipboard to the OS clipboard: https://stackoverflow.com/a/61379319/1884158
nnoremap <C-@> :call system("wl-copy", @")<CR>

set ignorecase

