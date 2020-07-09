" don't need to be compatible with vi
set nocompatible 

" 
" Plugins
" 
call plug#begin()

" Libraries
Plug 'rizzatti/funcoo.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'

" Vader for unit tests
Plug 'junegunn/vader.vim'

" Syntax and highlight
Plug 'altercation/vim-colors-solarized'
Plug 'cakebaker/scss-syntax.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'plasticboy/vim-markdown'

" General UI
Plug 'mhinz/vim-startify'
Plug 'itchyny/lightline.vim'
Plug 'bling/vim-bufferline'

" Coding assistance
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Townk/vim-autoclose'
Plug 'scrooloose/syntastic'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-scripts/argtextobj.vim'
Plug 'michaeljsmith/vim-indent-object'
"Plug 'chaoren/vim-wordmotion'
Plug 'Aggroboy/vim-wordmotion'

" Commenting plugins - pick one
Plug 'tomtom/tcomment_vim'

Plug 'ctrlpvim/ctrlp.vim'

call plug#end()



" General VIM config
" ==================

filetype plugin indent on
set updatetime=100              " makes various things happen faster then the fefault 4 seconds
cabbr <expr> %% expand('%:p:h') " make %% expand to the directory containing the current file
set number
set laststatus=2                " Always show the status line
set incsearch
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set nofoldenable
imap <D-V> ^O"+p"               " Automatically use paste mode when pasting
set backup
set backupdir=$HOME/.backups
set directory^=$HOME/.backups// "put all swap files together in one place
set backupcopy=yes
set spelllang=en_gb
set smarttab expandtab shiftwidth=4 tabstop=4
set signcolumn=yes
noremap <silent> <S-Right> :bn!<cr>
noremap <silent> <S-Left> :bp!<cr>
" Return the cursor to it's last position on open
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


" Indenting
" =========

set formatoptions=tcroq
set cinoptions=(0t0l0
set cindent


" Gui options
" ===========
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


" Syntax highlighting
" ===================
if &t_Co > 2 || has("gui_running")
    syntax enable
    set hlsearch
    set background=light
    colorscheme solarized
    highlight clear SignColumn

    map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
endif


" Plugin config
" ==============

" Wordmotion
let g:Wordmotion_Spaces = ''
let g:wordmotion_spaces = '_-'

" turn off cowsy header in startify
let g:startify_custom_header =[]

" gitgutter colors
highlight GitGutterAdd    guifg=#00af00 ctermfg=34
highlight GitGutterChange guifg=#d78700 ctermfg=172
highlight GitGutterDelete guifg=#d75f00 ctermfg=166
let g:gitgutter_sign_added= '<❙'
let g:gitgutter_sign_modified = '~|'
let g:gitgutter_sign_removed = '◣_'
let g:gitgutter_sign_modified_removed = '~‗'

" bufferline - stop it overwriting the commandline
let g:bufferline_echo = 0

" CtrlP
let g:ctrlp_max_files = 5000

" Supertab
let g:SuperTabCrMapping = 1

" Syntastic
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['python', 'pylint']
let g:syntastic_mode_map = {
            \ "mode": "passive",
            \ "active_filetypes": [],
            \ "passive_filetypes": ["python"] }
function! s:syntastic()
    SyntasticCheck
    call lightline#update()
endfunction

" IndentLine
let g:indentLine_char= '¦'
let g:indentLine_color_term=252
let g:indentLine_color_gui='#e0e0e0'


" Filetype specific settings and overrides
" =================================

" Plaintext
au FileType markdown setlocal nocindent textwidth=116 spell autoindent
au FileType text setlocal nocindent formatoptions= textwidth=116 spell noautoindent
au FileType doxiaapt setlocal nocindent textwidth=116 spell autoindent

" Coding
au FileType make setlocal noexpandtab shiftwidth=8 tabstop=8
au FileType python let python_highlight_all=1


" Lightline
" =========
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

