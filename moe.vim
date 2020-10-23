" Initialization: {{{
highlight clear
if exists("syntax_on")
  syntax reset
endif
set background=dark
let g:colors_name="moe"
" }}}
" Function: {{{
function! s:HL(group, style)
  execute "highlight" a:group
        \ "guifg="  (has_key(a:style, 'fg')   ? a:style.fg[0]   : 'NONE')
        \ "guibg="  (has_key(a:style, 'bg')   ? a:style.bg[0]   : 'NONE')
        \ "guisp="  (has_key(a:style, 'sp')   ? a:style.sp[0]   : 'NONE')
        \ "gui="    (has_key(a:style, 'gui')  ? a:style.gui     : 'NONE')
        \ "ctermfg="(has_key(a:style, 'fg')   ? a:style.fg[1]   : 'NONE')
        \ "ctermbg="(has_key(a:style, 'bg')   ? a:style.bg[1]   : 'NONE')
        \ "cterm="  (has_key(a:style, 'cterm')  ? a:style.cterm : 'NONE')
endfunction
" }}}
" Palette: {{{
" scarlett  :#ff4b4b vs. 256:#ff5f5f
" red       :#a40000 vs. 256:#800000
" brightred :#dd0000 vs. 256:#d70000
" green     :#a0db00 vs. 256:#afd700
" purple    :#d18aff vs. 256:#d787ff
" magenta   :#ff4ea3 vs. 256:#ff5faf
let s:color = {
      \ 'scarlett': ['#ff4b4b', 203],
      \ 'red':      ['#a40000',   1],
      \ 'brightred':['#dd0000', 160],
      \ 'orange':   ['#ff8700', 208],
      \ 'yellow':   ['#ffd700', 220],
      \ 'green':    ['#a0db00', 148],
      \ 'limegreen':['#d7ff5f', 191],
      \ 'orient':   ['#005faf',  24],
      \ 'blue':     ['#5fafd7',  74],
      \ 'skyblue':  ['#afd7ff', 153],
      \ 'purple':   ['#d18aff', 177],
      \ 'orchid':   ['#af5fd7', 134],
      \ 'magenta':  ['#ff4ea3', 205],
      \ 'Vff':      ['#ffffff',  15],
      \ 'Vee':      ['#eeeeee', 255],
      \ 'Vc6':      ['#c6c6c6', 251],
      \ 'Vb2':      ['#b2b2b2', 249],
      \ 'V6c':      ['#6c6c6c', 242],
      \ 'V4e':      ['#4e4e4e', 239],
      \ 'V3a':      ['#3a3a3a', 237],
      \ 'V30':      ['#303030', 236],
      \ 'V26':      ['#262626', 235],
      \ }

" }}}
" Highlights: {{{
" Syntax: {{{
  call s:HL('Normal', {'fg': s:color.Vc6, 'bg': s:color.V30})

  call s:HL('Comment', {'fg': s:color.V6c})

  call s:HL('Constant', {'fg': s:color.blue})
  call s:HL('String', {'fg': s:color.magenta})

  call s:HL('Identifier', {'fg': s:color.orange})
  call s:HL('Function', {'fg': s:color.yellow})

  call s:HL('Statement', {'fg': s:color.green})
  hi! link Operator Normal

  call s:HL('PreProc', {'fg': s:color.purple})

  call s:HL('Type', {'fg': s:color.blue})

  call s:HL('Special', {'fg': s:color.yellow})
" }}}
" Special: {{{
  hi! link SpecialKey Constant
  call s:HL('Underlined', {'fg': s:color.blue, 'gui': 'underline', 'cterm': 'underline'})
  call s:HL('Ignore', {'fg': s:color.V6c})
  call s:HL('Error', {'fg': s:color.Vee, 'bg': s:color.brightred})
  call s:HL('Todo', {'fg': s:color.red})

  call s:HL('IncSearch', {'gui': 'reverse', 'cterm': 'reverse'})
  call s:HL('Search', {'gui': 'bold', 'cterm': 'underline'})
  call s:HL('Visual', {'bg': s:color.V6c})
  call s:HL('Folded', {'fg': s:color.Vc6, 'bg': s:color.V4e})
  hi! link Conceal Folded
" }}}
" Cursor: {{{
  call s:HL('Cursor', {'bg': s:color.Vee})
  call s:HL('CursorLine', {'bg': s:color.V3a})
  hi! link CursorColumn CursorLine
  hi! link ColorColumn CursorLine

  call s:HL('LineNr', {'fg': s:color.Vb2, 'bg': s:color.V4e})
  call s:HL('CursorLineNr', {'fg': s:color.V3a, 'bg': s:color.limegreen})
  hi! link FoldColumn LineNr
  hi! link SignColumn LineNr

  call s:HL('MatchParen', {'gui': 'bold', 'cterm': 'underline'})
" }}}
" UI: {{{
  call s:HL('VertSplit', {'fg': s:color.Vc6, 'bg': s:color.V26})

  call s:HL('TabLineSel', {'fg': s:color.Vff, 'bg': s:color.purple})
  call s:HL('TabLine', {'fg': s:color.purple, 'bg': s:color.V26})
  call s:HL('TabLineFill', {'bg': s:color.V26})

  call s:HL('StatusLine', {'fg': s:color.Vff, 'bg': s:color.orchid})
  call s:HL('StatusLineNC', {'fg': s:color.Vc6, 'bg': s:color.V4e})
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC

  call s:HL('WildMenu', {'fg': s:color.purple})
  call s:HL('Directory', {'fg': s:color.purple})

  call s:HL('MoreMsg', {'fg': s:color.green})
  call s:HL('ErrorMsg', {'fg': s:color.red, 'bg': s:color.V26})
  call s:HL('WarningMsg', {'fg': s:color.red})

  hi! link NonText Comment
  call s:HL('Title', {'fg': s:color.blue})
  hi! link Question MoreMsg

  call s:HL('ToolbarLine', {'bg': s:color.V26})
  call s:HL('ToolbarButton', {'fg': s:color.orchid})
" }}}
" Spell: {{{
  call s:HL('SpellBad', {'fg': s:color.red, 'bg': s:color.V26})
  call s:HL('SpellCap', {'bg': s:color.V26})
  call s:HL('SpellRare', {'fg': s:color.blue, 'bg': s:color.V26})
  call s:HL('SpellLocal', {'fg': s:color.purple, 'bg': s:color.V26})
" }}}
" Diff: {{{
  call s:HL('DiffAdd', {'fg': s:color.limegreen, 'bg': s:color.V3a})
  call s:HL('DiffChange', {'fg': s:color.yellow, 'bg': s:color.V3a})
  call s:HL('DiffDelete', {'fg': s:color.red, 'bg': s:color.V3a})
  call s:HL('DiffText', {'fg': s:color.orange, 'bg': s:color.V3a})
" }}}
" Popup: {{{
  call s:HL('Pmenu', {'fg': s:color.blue, 'bg': s:color.V4e})
  call s:HL('PmenuSel', {'fg': s:color.skyblue, 'bg': s:color.orient})
  call s:HL('PmenuSbar', {'fg': s:color.V4e, 'bg': s:color.V4e})
  call s:HL('PmenuThumb', {'fg': s:color.Vb2, 'bg': s:color.Vb2})
" }}}
" Plugins: {{{
" VimWiki: {{{
  call s:HL('VimwikiHeader1', {'fg': s:color.green, 'gui': 'bold'})
  call s:HL('VimwikiHeader2', {'fg': s:color.blue, 'gui': 'bold'})
  call s:HL('VimwikiHeader3', {'fg': s:color.yellow, 'gui': 'bold'})
  call s:HL('VimwikiHeader4', {'fg': s:color.magenta, 'gui': 'bold'})
  call s:HL('VimwikiHeader5', {'fg': s:color.purple, 'gui': 'bold'})
  call s:HL('VimwikiHeader6', {'fg': s:color.orange, 'gui': 'bold'})
" }}}
" Traces:{{{
  call s:HL('TracesSearch', {'bg': s:color.V26})
  call s:HL('TracesReplace', {'bg': s:color.V30})
" }}}
" Nerdtree: {{{
  call s:HL('NERDTreeDir', {'fg': s:color.blue})
  call s:HL('NERDTreeFlag', {'fg': s:color.yellow})
" }}}
" }}}
" }}}
" Footer: {{{
" Name: Moe
" Description: Attempted port of Moe-theme.el
" Author: Mcraisins
" vim: set sw=2 ts=2 sts=0 et ft=vim fdm=marker fmr={{{,}}}:
" }}}
