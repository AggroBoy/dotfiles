"don't need to be compatible with vi
set nocompatible 

"set vundle up
call system("mkdir -p $HOME/.vim")
let has_vundle=1
if !filereadable($HOME."/.vim/bundle/vundle/README.md")
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p $HOME/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
    let has_vundle=0
endif
filetype off                                " required to init
set rtp+=$HOME/.vim/bundle/vundle/          " include vundle
call vundle#rc()                            " init vundle
Bundle 'gmarik/vundle'

" bundles
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'

Bundle 'altercation/vim-colors-solarized'

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'Rip-Rip/clang_complete'
Bundle 'Townk/vim-autoclose'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'ervandew/supertab'

Bundle 'mhinz/vim-startify'
Bundle 'Shougo/unite.vim'

Bundle 'itchyny/lightline.vim'
Bundle 'bling/vim-bufferline'

Bundle 'plasticboy/vim-markdown'
Bundle 'cakebaker/scss-syntax.vim'

Bundle 'itspriddle/vim-marked'

if has_vundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif


"make %% expand to the directory containing the current file
cabbr <expr> %% expand('%:p:h')

"we like the moon... no, line numbers!
set number

"statusline
set laststatus=2

"incremental search is always nice
set incsearch

"show the current mode
set showmode

"display incomplete comands
set showcmd

"turn on the ruler (show the columns in the position display)
set ruler

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"turn on and configure auto formatting/indenting
set formatoptions=tcroq
set cinoptions=(0t0l0
set cindent

"text documents don't want any of that
au FileType markdown setlocal nocindent textwidth=76 spell autoindent
au FileType text setlocal nocindent formatoptions= textwidth=76 spell noautoindent
au FileType doxiaapt setlocal nocindent textwidth=76 spell autoindent
let g:vim_markdown_initial_foldlevel=4

"Automatically use paste mode when pasting
imap <D-V> ^O"+p"

"spelling language
set spelllang=en_gb

"configure backups (and .swps)
set backup
set backupdir=$HOME/.backups
set directory^=$HOME/.backups//   "put all swap files together in one place
set backupcopy=yes

"make tabs work as expected (expand to spaces and 4 of them at that)...
set smarttab expandtab shiftwidth=4 tabstop=4

"except for makefiles where that spells disaster (they need real tabs)
au FileType make setlocal noexpandtab shiftwidth=8 tabstop=8


"set the gui options
if has("gui_running")
    set guioptions-=T
    set guioptions-=t
    set columns=100 lines=35
    if has("win32")
        set guifont=Consolas:h9
    else
        set guifont=Source\ Code\ Pro:h12
    endif
endif

"turn on fancy python syntax highlighting
let python_highlight_all = 1

"things to do if syntax highlighting is available (when you're dead)
if &t_Co > 2 || has("gui_running")
    syntax enable
    set hlsearch
    set background=light
    colorscheme solarized
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END

else

    set autoindent        " always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
            \ | wincmd p | diffthis

" Configure the status bar
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ 'active': {
            \     'left': [
            \         ['mode', 'paste'],
            \         ['fugitive', 'readonly'],
            \         ['ctrlpmark', 'bufferline']
            \     ],
            \     'right': [
            \         ['lineinfo'],
            \         ['percent'],
            \         ['fileformat', 'fileencoding', 'filetype', 'syntastic']
            \     ]
            \ },
            \ 'component': {
            \     'paste': '%{&paste?"!":""}'
            \ },
            \ 'component_function': {
            \     'mode'         : 'MyMode',
            \     'fugitive'     : 'MyFugitive',
            \     'readonly'     : 'MyReadonly',
            \     'ctrlpmark'    : 'CtrlPMark',
            \     'bufferline'   : 'MyBufferline',
            \     'fileformat'   : 'MyFileformat',
            \     'fileencoding' : 'MyFileencoding',
            \     'filetype'     : 'MyFiletype'
            \ },
            \ 'component_expand': {
            \     'syntastic': 'SyntasticStatuslineFlag',
            \ },
            \ 'component_type': {
            \     'syntastic': 'middle',
            \ },
            \ 'subseparator': {
            \     'left': '|', 'right': '|'
            \ }
            \ }

let g:lightline.mode_map = {
            \ 'n'      : ' N ',
            \ 'i'      : ' I ',
            \ 'R'      : ' R ',
            \ 'v'      : ' V ',
            \ 'V'      : 'V-L',
            \ 'c'      : ' C ',
            \ "\<C-v>" : 'V-B',
            \ 's'      : ' S ',
            \ 'S'      : 'S-L',
            \ "\<C-s>" : 'S-B',
            \ '?'      : '      ' }

function! MyMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! MyFugitive()
    try
        if expand('%:t') !~? 'Tagbar' && exists('*fugitive#head')
            let mark = '± '
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! MyReadonly()
    return &ft !~? 'help' && &readonly ? '≠' : '' " or ⭤
endfunction

function! CtrlPMark()
    if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    \ , g:lightline.ctrlp_next], 0)
    else
        return ''
    endif
endfunction

function! MyBufferline()
    call bufferline#refresh_status()
    let b = g:bufferline_status_info.before
    let c = g:bufferline_status_info.current
    let a = g:bufferline_status_info.after
    let alen = strlen(a)
    let blen = strlen(b)
    let clen = strlen(c)
    let w = winwidth(0) * 4 / 11
    if w < alen+blen+clen
        let whalf = (w - strlen(c)) / 2
        let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
        let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
        return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
    else
        return b . c . a
    endif
endfunction

function! MyFileformat()
    return winwidth('.') > 90 ? &fileformat : ''
endfunction

function! MyFileencoding()
    return winwidth('.') > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyFiletype()
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
    return lightline#statusline(0)
endfunction

augroup AutoSyntastic
    autocmd!
    autocmd BufWritePost *.c,*.cpp,*.perl,*py call s:syntastic()
augroup END
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction


nnoremap <C-p> :Unite file_rec<cr>


