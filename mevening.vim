" First remove all existing highlighting.
set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "mevening"

" Colors used in status line

" Orange
hi User1 guifg=#eea040 guibg=#222222

" Red
hi User2 guifg=#dd3333 guibg=#222222

" ???
hi User3 guifg=#ff66ff guibg=#222222

" Green
hi User4 guifg=#a0ee40 guibg=#222222

" ???
hi User5 guifg=#eeee40 guibg=#222222

hi Normal guifg=White guibg=grey20

" Groups used in the 'highlight' and 'guicursor' options default value.
hi ErrorMsg     guibg=#dd3333 guifg=White
hi IncSearch    gui=reverse
hi ModeMsg      gui=bold
hi StatusLine   guibg=#222222
hi StatusLineNC guibg=#222222
hi VertSplit    guibg=#222222 guifg=#222222
hi Visual       guibg=grey60
hi VisualNOS    gui=underline,bold
hi DiffText     gui=bold guibg=#dd3333
hi Cursor       guibg=#eea040 guifg=Black
hi lCursor      guibg=Cyan guifg=Black
hi Directory    guifg=Cyan
hi LineNr       guifg=grey60
hi CursorLineNr guifg=#eea040
hi MoreMsg      gui=bold guifg=SeaGreen
hi NonText      gui=bold guifg=LightBlue guibg=grey30
hi Question     gui=bold guifg=Green
hi Search       guibg=Yellow guifg=Black
hi SpecialKey   guifg=Cyan
hi Title        gui=bold guifg=Magenta
hi WarningMsg   guifg=#f0799f 
hi WildMenu     guibg=Yellow guifg=Black
hi Folded       guibg=#222222 guifg=White
"hi FoldColumn   guibg=Grey guifg=White
hi DiffAdd      guibg=DarkBlue
hi DiffChange   guibg=DarkMagenta
hi DiffDelete   gui=bold guifg=Blue guibg=DarkCyan
hi Pmenu        guibg=grey30
hi SignColumn   guibg=grey20

" Clear this to get cursorline enabled but only highlight the line number
hi clear CursorLine

" Groups for syntax highlighting
hi Constant     guifg=#ffa0a0
hi Special      guifg=Orange
hi Statement    guifg=#ffff60 gui=bold
hi Type         guifg=#60ff60 gui=bold
hi Ignore       guifg=grey20

" vim-gitgutter
hi GitGutterDelete  guifg=#80a0ff guibg=grey20
hi diffRemoved      guifg=#80a0ff

" coc.nvim
hi link CocErrorSign WarningMsg

" vim: sw=2
