" Required: {{{
set nocompatible
filetype plugin on
syntax on
" }}}
" VimPlug Plugins: {{{
call plug#begin()
Plug 'luochen1990/rainbow'
Plug 'w0rp/ale'
Plug 'markonm/traces.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'lifepillar/vim-mucomplete'
Plug 'vimwiki/vimwiki'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
call plug#end()
" }}}
" Plugin Configs: {{{
" Ale: {{{

" Allow autocompletion
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

" ALEFix functionallity
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}

" Show me which checker is mentioning error and color them
let g:ale_echo_msg_format = '%linter% : %s'
let g:ale_set_highlights = 1

" Remove cc linter and other oddities
let g:ale_linters = {'c': ['cppcheck', 'clangd', 'ccls', 'cquery']}

" Set options for linters
let g:ale_c_cc_options = '--std=c99 -I/usr/include -I${BASE_DIR}/include -I${BASE_DIR}/clib/include -I${BASE_DIR}/clib/include/oper -I${BASE_DIR}/clib/pywcs'
let g:ale_c_cppcheck_options = '--enable=all -DUSE_PROTOS -D_AIX_SOURCE --std=c89 -I/usr/include -I${BASE_DIR}/include -I${BASE_DIR}/clib/include -I${BASE_DIR}/clib/include/oper -I${BASE_DIR}/clib/pywcs'

" Set options for cpu reasons
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0

augroup ag_ale
    au!
    au BufWrite * :ALEFix
    au VimEnter * execute ':ALEDisable'
augroup END
" }}}
" EasyTags And SemanticHighlight: {{{
"
" Run on tag file if exists, otherwise ~/vimtags
let g:easytags_dynamic_files = 1

" Overwrite all automatic ctags update events. Manual only
let g:easytags_events = []

" Run silently in background if possible
let g:easytags_async = 1
let g:easytags_auto_highlight = 1
let g:easytags_on_cursorhold = 1

" Use python for better optimizationg
let g:easytags_python_enabled = 1
let g:easytags_python_script = 1

" Toggle default behavior for file highlighting
let g:tag_hl = 1
function! s:HlToggle()
    if g:tag_hl == 1
        let g:tag_hl = 2
        echo ':HighlightTags'
    elseif g:tag_hl == 2
        let g:tag_hl = 0
        echo ':SemanticHighlight'
    else
        let g:tag_hl = 1
        echo 'No automatic highlight'
    endif
endfunction

" Starts at no highlight, then tag hl, then semantic hl
function! HlAuto()
    if g:tag_hl == 2
        execute ':HighlightTags'
    elseif g:tag_hl == 0
        execute ':SemanticHighlight'
    endif
endfunction

" run on every buffer
augroup ag_easytags
    au!
    au bufread * :call HlAuto()
augroup end

" Update all tag files
command! CtagsUpdate execute ":UpdateTags -RV --exclude=protos.h --exclude=dummies.h ."
" }}}
" RainbowParenthesis: {{{
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['#ffd700', '#5fafd7', '#ff8700', '#d18aff', '#ff4ea3', '#afd700', '#80a0ff'],
\   'ctermfgs': [220, 74, 208, 177, 205, 111],
\   'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
\   'contains_prefix': 'TOP',
\   'parentheses_options': 'containedin=ALL',
\   'separately': {
\       '*': {},
\       'vim': {'parentheses_options': 'containedin=vimFuncBody,vimExecute'},
\       'c': {'parentheses_options': 'containedin=ALLBUT,cComment,cCppString'},
\       'vimwiki': 0,
\   }
\}

" run on every buffer
augroup ag_rainbow
    au!
    au bufread * :RainbowToggleOn
augroup end
" }}}
" AirLine: {{{
" Show more states on airline
let g:airline_detect_spell = 1
let g:airline_detect_paste = 1
let g:airline_detect_modified = 1

" Enable tabline and show buffer numbers on it
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
nmap <C-x>1 <Plug>AirlineSelectTab1
nmap <C-x>2 <Plug>AirlineSelectTab2
nmap <C-x>3 <Plug>AirlineSelectTab3
nmap <C-x>4 <Plug>AirlineSelectTab4
nmap <C-x>5 <Plug>AirlineSelectTab5
nmap <C-x>6 <Plug>AirlineSelectTab6
nmap <C-x>7 <Plug>AirlineSelectTab7
nmap <C-x>8 <Plug>AirlineSelectTab8
nmap <C-x>9 <Plug>AirlineSelectTab9
nmap <C-x>- <Plug>AirlineSelectPrevTab
nmap <C-x>+ <Plug>AirlineSelectNextTab

" Blank seperators since they look bad without good fonts
let g:airline_left_sep = ''
let g:airline_right_sep = ''

" Kinda works with moe
" Changed modified foreground highlight to Statement.bg:line 21
" Changed insert background highlight to Statement.bg:line 25
let g:airline_theme = 'biogoo'

" Allow airline to use ale
let g:airline#extensions#ale#enabled = 1
" }}}
" NERDTree: {{{
" Show hidden files
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
" }}}
" VimWiki: {{{
" Add template to html'ed wikis
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'template_path':'~/vimwiki/templates',
            \ 'template_default':'default',
            \ 'template_ext':'.html',
            \ 'auto_toc': 1}]
nnoremap <leader>w<leader>m :e ~/vimwiki/Music.wiki<CR>
" }}}
" Snipmate: {{{
imap <C-d> <Plug>snipMateNextOrTrigger
smap <C-d> <Plug>snipMateNextOrTrigger
imap <C-f> <Plug>snipMateBack
smap <C-f> <Plug>snipMateBack
imap <C-g> <Plug>snipMateShow
xmap <C-d> <Plug>snipMateNextOrTrigger
" }}}
" }}}
" Settings: {{{

" Recurse up from cd to find tags file
set tags=./tags;

" Use cscope database first and show messages
set cscopetag
set csto=0
set cscopeverbose

" Dont force every buffer to have a window open
set hidden

" Highlight searches, show matches as I type, and ignore case
set hlsearch
set incsearch
set ignorecase

" use vim icon
set guioptions=i
" Stop opening dialog popups
set guioptions+=c

" for wild complete, fill longest common string and list, then tab through
set wildmode=longest:list,full

" allow delete indent, eol, and before start pos. stop once at start pos
set backspace=indent,eol,start

" Rows and columns around cursor while scrolling
set sidescroll=1
set sidescrolloff=4
set scrolloff=2

" softtabstop=0 with compatible, always use spaces, dont auto newline
set softtabstop=0
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=0

" Set c specific indent options to match whitesmith style
set cinoptions={s,(0,i0,p0,^-s

" Fold like-indented rows, don't fold on load, don't open folds while searching
" undoing or navigating with {}
set foldmethod=indent
set foldopen-=block
set foldopen-=search
set foldopen-=undo
set nofoldenable

" Enable line numbers and cursor row highlight
set number
set relativenumber
set cursorline

" Get these swap files out of my face
set backupdir=~/.vim/backups//
set directory=~/.vim/swapfiles//

" open menu for single items and open popup info
set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
set noinfercase

" shortmess is crazy complicated. :h shortmess
set shortmess=imrxtoOTAIc

" dont make noise
set belloff+=all
" }}}
" TabLine: {{{
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let tabnr = i + 1
        let winnr = tabpagewinnr(tabnr)
        let buflist =tabpagebuflist(tabnr)
        let bufnr = buflist[winnr - 1]
        let bufname = fnamemodify(bufname(bufnr), ':t')

        let s .= '%' . tabnr . 'T'
        let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
        let s .= ' ' . tabnr

        let n = tabpagewinnr(tabnr, '$')
        if n > 1 | let s .= ':' . n | endif

        let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '

        let bufmodified = getbufvar(bufnr, '&mod')
        if bufmodified | let s.= '+ ' | endif
    endfor

    let s .= '%#TabLineFill#'
    return s
endfunction

" set tabline=%!MyTabLine()
" }}}
" Highlights: {{{
colorscheme moe
" }}}
" AutoGroups: {{{
" VimWiki: {{{
function! s:vimwiki_hi()
    syntax match myVimWikiInfo '\v\[[^\[\]]+\](])@!'
    hi link myVimWikiInfo Type

    syntax match myVimWikiTime '\v\[(\d\d[:-]?)+\]'
    hi link myVimWikiTime Function

    syntax match myVimWikiArchive '\v\[Archive\]'
    hi link myVimWikiArchive Identifier

    syntax match myVimWikiLog '\v\[Log\]'
    hi link myVimWikiLog Statement
endfunction

augroup ft_vw
    au!
    au Filetype vimwiki nnoremap <buffer> <C-d> i[<C-R>=strftime("\%H:\%M:\%S")<CR>]<Space><Esc>
    au Filetype vimwiki inoremap <buffer> <C-d> [<C-R>=strftime("\%H:\%M:\%S")<CR>]<Space>
    au Filetype vimwiki nnoremap <buffer> <M-d> i[<C-R>=strftime("\%m-\%d")<CR>]<Space><Esc>
    au Filetype vimwiki inoremap <buffer> <M-d> [<C-R>=strftime("\%m-\%d")<CR>]<Space>
    au Filetype vimwiki :call s:vimwiki_hi()
    au BufRead */vimwiki/diary/diary.wiki :VimwikiDiaryGenerateLinks
augroup END
" }}}
" C: {{{
function! s:c_hi()
    "look for alphanumeric strings, a space, /*-+~ with a = and excludes ==
    syntax match myCAssigned '\v\zs([\*-9\<\>-z]+)\ze\s*[\/\*\-\+\~]?\=[^=]'
    hi link myCAssigned Identifier
endfunction

" Fold curly brackets
augroup ft_c
    au!
    au BufNewFile,BufRead *.h set filetype=c
    au FileType c setlocal foldmethod=marker foldmarker={,}
    au Filetype c :call s:c_hi()
augroup END
" }}}
" Vim: {{{
augroup ft_vim
    au!
augroup END
" }}}
" }}}
" Mappings: {{{
" Navigation Mappings: {{{
" Center text when jumping
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Go up and down displayed lines, not actual lines of file
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <DOWN> g<DOWN>
noremap <UP> g<UP>
noremap g<DOWN> <DOWN>
noremap g<UP> <UP>

" Jump to ends while command or insert
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>
nnoremap <c-a> <home>
nnoremap <c-e> <end>

" Paste while in insert
inoremap <c-p> <esc>pi
" }}}
" UI Mappings: {{{
" Toggle relative line numbers for other people

" Tool to find highlight of cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name")
            \ . "> trans<" . synIDattr(synID(line("."),col("."),0),"name")
            \ . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Pressing escape removes search highlights
nnoremap <esc> :silent! noh<return><esc>

" Term settings
nnoremap <silent> <ESC>OA <up>
nnoremap <silent> <ESC>OB <down>
nnoremap <silent> <ESC>OC <right>
nnoremap <silent> <ESC>OD <left>
" }}}
" Buffer And Tab Mappings: {{{
" Buffer mappings
nnoremap <C-x><left> :bprev<CR>
nnoremap <C-x><h> :bprev<CR>
nnoremap <C-x><right> :bnext<CR>
nnoremap <C-x><l> :bnext<CR>
nnoremap <C-x><C-x> :bp\|bd #<CR>
"}}}
" Ctags Mappings: {{{
" Mappings for cscope commands. \ to replace window, 1 space for horizontal
" split, 2 spaces for vertical split
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cword>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space><C-Space>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space><C-Space>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"}}}
" Misc: {{{
set pastetoggle=<F2>
" }}}
" }}}
" Commands: {{{

" Archiver function. When archive is 1, deletes original selection
function! s:DiaryArchiver(archive) range
    let s:mypath = join([expand('~'),'/vimwiki/diary/',strftime("\%Y-\%m-\%d"),'.wiki'], "")

    redraw!
    let s:myinput = input("Description: ")
    redraw!

    let message1 = join(['* [', strftime('%H:%M:%S'), '] ['
                \, ((a:archive == 0)?'Log':'Archive'),'] ['
                \, bufname(),':',a:firstline,'-',a:lastline,'] ', s:myinput], "")
    let message2 = join(['{{{', ((&ft != 'vimwiki')?&ft:'')], "")
    call writefile([message1, message2], s:mypath, "a")

    for lnum in range(a:firstline, a:lastline)
        call writefile([join(['    ',getline(lnum)],'')], s:mypath, "a")
    endfor

    call writefile(['}}}'], s:mypath, "a")
    if a:archive == 1
        call deletebufline(bufname(), a:firstline, a:lastline)
    endif
    update
endfunction

" Archives or logs current selection to end of todays diary
command! -range Archive <line1>,<line2>call s:DiaryArchiver('1')
command! -range Log <line1>,<line2>call s:DiaryArchiver('0')

" Simple logger function to quickly append to file
function! s:WikiWrite(wiki, prompt, ...)
    let s:mypath = join([expand('~'),'/vimwiki/', a:wiki,'.wiki'], "")

    redraw
    let s:myinput = input(a:prompt)
    redraw!
    if s:myinput == '' | return | endif

    let s:argslist = get(a:, 1, [])
    let s:messagelist = []
    for i in s:argslist
        if i == 'tab' | call add(s:messagelist, '    ') | endif
        if i == '*' | call add(s:messagelist, '*') | endif
        if i == '[]' | call add(s:messagelist, '[ ]') | endif
        if i == 'time' | call add(s:messagelist, join(['[',strftime('%H:%M:%S'),']'],"")) | endif
        if i == 'date' | call add(s:messagelist, join(['[',strftime('%m-%d'),']'],"")) | endif
    endfor
    call add(s:messagelist, s:myinput)

    call writefile([join(s:messagelist)], s:mypath, "a")
endfunction

" Various quick log to wikis
command! DiaryLog :call s:WikiWrite(join(['diary/',strftime("\%Y-\%m-\%d")],""), 'Journal entry: ', ['*', 'time'])
command! MusicLog :call s:WikiWrite('Music', 'Song: ', ['*', 'date', 'time'])
command! TaskAdd  :call s:WikiWrite('index', 'TODO: ', ['*', '[]', 'date'])
command! SubTaskAdd  :call s:WikiWrite('index', 'TODO: ', ['tab', '*', '[]', 'date'])

command! -nargs=? LastSong for line in readfile(glob('~/vimwiki/Music.wiki'), '', -1*(<q-args>?<q-args>:3)) | echo line | endfor

" Calls HlToggle
command! Hltoggle :call s:HlToggle()

" Just let me switch relativenumber whenever
command! RelativeNumToggle set relativenumber!

" Quickly make new setups. I don't use these much
command! NewVim execute "!~/bin/vim -g"
command! NewTerm execute "! xterm -e bash &"

"look at all processes in the system and sort them by # column (defaults to cpu)"
command! -nargs=? PsCheck execute "!ps aux | awk 'NR<2{print $0;next}{print $0|\"sort -rnk ".(<q-args>?<q-args>:3)."\"}' | head -n30"
" }}}
" Footer: {{{
" Name: Vimrc
" Description: Constantly adjusted .vimrc (seriously I need to stop messing with it)
" Author: Ryan Lira
" vim: set sw=4 ts=4 sts=0 et ft=vim fdm=marker fmr={{{,}}}:
" }}}
