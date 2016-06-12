" acme.vim colorscheme
" based on Pike's acme editor
" by Case Duckworth

augroup Development
    au!
    au BufWritePost acme.vim colorscheme acme
augroup END

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name = 'acme'
set background=light

" Palette :       [GUI,       256, 8]
let s:fg        = ['#000000', 0,   0]
let s:bg        = ['#ffffea', 230, 7]
let s:tag       = ['#eaffff', 195, 6]
let s:handle    = ['#8888cc', 104, 4]
let s:dirty     = ['#000099', 18,  4]
let s:selected  = ['#eeee9e', 229, 3]
let s:scroll    = ['#99994c', 101, 3]
let s:red       = ['#aa0000', 1,   1]
let s:green     = ['#006600', 2,   2]

let s:bold      = 'bold,'
let s:italic    = 'italic,'
let s:underline = 'underline,'
let s:undercurl = 'undercurl,'
let s:inverse   = 'inverse,'

let s:vim_bg = ['bg',   'bg',   'bg']
let s:vim_fg = ['fg',   'fg',   'bg']
let s:none   = ['NONE', 'NONE', 'NONE']

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp
  " Or: group, link
  if (type(a:fg) == 1) " string, meaning it's a link
      execute 'hi! link' a:group a:fg
      return
  endif

  let fg = a:fg

  if (a:0 >= 1)
    let bg = a:1
  else
    let bg = s:none
  endif

  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  if (!has('gui_running') || empty($DISPLAY) || &t_Co != 256)
      " set cterm element in color arrays
      let s:ccol = 2
  else
      let s:ccol = 1
  endif

  let histring = [ 'hi', a:group,
      \ 'guifg=' . fg[0], 'ctermfg=' . fg[s:ccol],
      \ 'guibg=' . bg[0], 'ctermbg=' . fg[s:ccol],
      \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
      \ ]

  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" To make things easier
call s:HL('Bold',              s:none,   s:none, s:bold)
call s:HL('Italic',            s:none,   s:none, s:italic)
call s:HL('Underline',         s:none,   s:none, s:underline)
call s:HL('BoldItalic',        s:none,   s:none, s:bold . s:italic)
call s:HL('BoldUnderline',     s:none,   s:none, s:bold . s:underline)

" Vim Highlight groups
call s:HL('Normal',            s:fg,     s:bg)

call s:HL('IncSearch',         s:none,   s:selected)
call s:HL('Search',            s:none,   s:selected)

call s:HL('CursorColumn',      s:none,   s:none)
call s:HL('CursorLine',        s:none,   s:none)

call s:HL('CursorLineNr',      s:scroll, s:selected)
call s:HL('LineNr',            s:bg,     s:selected)
call s:HL('FoldColumn',        s:scroll, s:selected)
call s:HL('SignColumn',        s:handle, s:selected)
call s:HL('ColorColumn',       s:none,   s:selected)

call s:HL('DiffAdd',           s:green, s:none, s:inverse)
call s:HL('DiffChange',        s:dirty,  s:none, s:inverse)
call s:HL('DiffDelete',        s:red, s:none, s:inverse)
call s:HL('DiffText',          s:dirty)

call s:HL('ErrorMsg',          s:red, s:none, s:inverse)
call s:HL('Question',          s:green)
call s:HL('WarningMsg',        s:red)
call s:HL('ModeMsg',           s:dirty)
call s:HL('WildMenu',          s:none,   s:tag,  s:inverse)
call s:HL('Title',             'Comment')

call s:HL('Cursor',            s:none,   s:none, s:inverse)
call s:HL('Directory',         'Bold')
call s:HL('Folded',            s:handle, s:dirty)
" call s:HL('Pmenu', 
" call s:HL('PmenuSbar', 
" call s:HL('PmenuSel', 

call s:HL('MatchParen',        s:handle, s:none, s:bold)
call s:HL('Visual',            s:none,   s:selected)

call s:HL('NonText',           s:scroll)
call s:HL('SpecialKey',        s:scroll)

call s:HL('VertSplit',         s:none,   s:tag)
call s:HL('StatusLine',        s:none,   s:tag,  s:bold . s:underline)
call s:HL('StatusLineNC',      s:none,   s:tag, s:underline)

call s:HL('TabLine',           s:none,   s:tag, s:underline)
call s:HL('TabLineFill',       s:none,   s:tag, s:underline)
call s:HL('TabLineSel',        s:dirty,  s:tag,  s:inverse)

call s:HL('SpellBad',          s:dirty,  s:bg,   s:underline)
call s:HL('SpellCap',          'SpellBad')
call s:HL('SpellLocal',        'SpellBad')
call s:HL('SpellRare',         'SpellBad')

" Syntax highlight groups 
call s:HL('Comment',           s:handle, s:none, s:italic)

call s:HL('Constant',          s:none)
call s:HL('String',            s:dirty)
call s:HL('Character',         s:none)
call s:HL('Number',            s:none)
call s:HL('Boolean',           s:none)
call s:HL('Float',             s:none)

call s:HL('Identifier',        s:none)
call s:HL('Function',          s:none)
call s:HL('VarId',             s:none)

call s:HL('Statement',         s:none)
call s:HL('Conditional',       s:none)
call s:HL('Repeat',            s:none)
call s:HL('Label',             s:none)
call s:HL('Operator',          s:none)
call s:HL('Keyword',           s:none)
call s:HL('Exception',         s:none)

call s:HL('PreProc',           s:none)
call s:HL('Include',           s:none)
call s:HL('Define',            s:none)
call s:HL('Macro',             s:none)
call s:HL('PreCondit',         s:none)

call s:HL('Type',              s:none)
call s:HL('StorageClass',      s:none)
call s:HL('Structure',         s:none)
call s:HL('Typedef',           s:none)

call s:HL('Special',           s:none)
call s:HL('SpecialChar',       s:none)
call s:HL('Tag',               s:none)
call s:HL('Delimiter',         s:none)
call s:HL('SpecialComment',    s:none)
call s:HL('Debug',             s:none)

call s:HL('Error',             s:red)
call s:HL('Todo',              s:green, s:selected)

" Filetype-specific
" " Haskell
call s:HL('haskellType',       'Underline')
call s:HL('haskellIdentifier', 'Italic')
" " SH
call s:HL('shHereDoc',         'Italic')
" " Vim
call s:HL('vimCommentTitle',    s:handle, s:none, s:italic . s:bold)
