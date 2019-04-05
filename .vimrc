"""" COMMON SETTINGS
set nocompatible                " vim defaults, not vi
"set t_Co=256

"""" VIM-PLUG
let s:plugin_dir='~/.vim/plugged'
let s:plug_file='~/.vim/autoload/plug.vim'

call plug#begin(s:plugin_dir)
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/CSApprox'
Plug 'vim-scripts/star-search'
call plug#end()

"""" YCM
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

"""" a.vim
let g:alternateRelativeFiles = 1 " Files opened with :A will open relative to cwd

"""" General
set autoindent smartindent                 " smarter indent behavior
autocmd FileType make setlocal noexpandtab " Don't insert spaces for makefiles
set smarttab                               " make tab and backspace smarter
set nowrap                                 " don't wrap long lines
set number                                 " display line numbers
set norelativenumber                       " display relative line numbers
set hidden                                 " allow switching buffers without saving
set hlsearch                               " highlight search matches
set backspace=indent,eol,start             " allow backspace over indent, eol, start
set formatoptions=tcqlron                  " auto-wrap lines/comments at textwidth,
                                           " allow formatting using gq commands,
                                           " long lines not broken in insert mode
                                           " auto-insert comment leader on Enter or O,
                                           " recognize numbered lists
set directory=~/.vim/swapfiles//

set noincsearch     " incremental search highlight
set scrolloff=3     " show more context around cursor
"set cursorline      " highlight cursor line number

"""" Syntax
syntax on                       " enable syntax highlighting
"set foldmethod=syntax           " syntax-based code folding, this was the cause of insane input lag
set nofoldenable                " disable folding (enable in USERS section)
set cinoptions=:0,l1,t0,g0      " case labels at column 0,
                                " align line after case label with label,
                                " return type declaration at column 0,
                                " c++ scope declarations at column 0

"""" Shortcuts
" forces (re)indentation of a block of code
nmap <c-j> vip=
" scroll forward one screen
nmap <space> <c-f>
" scroll backward one screen
nmap <bs> <c-b>
" cycle between split windows
nmap - <c-w>w
" toggle line wrapping
nmap <silent> tw :set wrap!<cr>
" toggle numbering
nmap <silent> tn :set number!<cr>
" default s seems eclipsed by c functionality. instead mapping s to 'insert
" one char and stay in normal mode'
"nnoremap s :exec "normal i".nr2char(getchar())."\e"<cr>
"nnoremap S :exec "normal a".nr2char(getchar())."\e"<cr>
" YouCompleteMe GoTo
nmap <F2> :YcmCompleter GoToImprecise<cr>
nmap <F3> :YcmCompleter GoTo<cr>
nmap <F4> :YcmCompleter GoToDefinition<cr>
nmap <F5> :YcmForceCompileAndDiagnostics<cr>
" YouCompleteMe FixIt
map <F9> :YcmCompleter FixIt<cr>
" Rebind jk to escape in insert mode
inoremap jk <esc>

" fzf mappings
map <c-p> :Files<cr>
map <c-l> :Buffer<cr>
map <c-s> :Rg<space>
nnoremap <c-n> :Rg<space><c-r><c-w><cr>
map <leader>t :GFiles<cr>
map <leader>h :Commands<cr>
map <leader>? :Helptags<cr>
map <leader>gs :GFiles?<cr>
map <leader>gl :Commits<cr>
map <leader>gbl :BCommits<cr>
imap <c-x><c-l> <plug>(fzf-complete-line)

"" vim-easy-align mappings
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Close split
nmap <c-u> :close<cr>

let $kernel_version=system('uname -r | tr -d "\n"')

"""" PROFILES 
" 4 Spaces (4 spaces instead of tabs)
set expandtab      " use spaces, not tabs
set tabstop=4      " tab this width of spaces
set shiftwidth=4   " indent this width of spaces
set softtabstop=4  " backspace amount when tab-aligned (like using tabs)

"" Kernel
"set noexpandtab                              " use tabs, not spaces
"set tabstop=8                                " tab this width of spaces
"set shiftwidth=8                             " indent this width of spaces
"au Syntax c,cpp syn match Error /^ \+/       " highlight any leading spaces
"au Syntax c,cpp syn match Error / \+$/       " highlight any trailing spaces
""au Syntax c,cpp syn match Error /\%>80v.\+/  " highlight anything past 80 in red
"au Syntax c,cpp syn keyword cType uint ubyte ulong boolean_t
"au Syntax c,cpp syn keyword cType int64_t int32_t int16_t int8_t
"au Syntax c,cpp syn keyword cType uint64_t uint32_t uint16_t uint8_t
"au Syntax c,cpp syn keyword cType u_int64_t u_int32_t u_int16_t u_int8_t
"au Syntax c,cpp syn keyword cOperator likely unlikely

"""" Statusline 
set laststatus=2                " Always show status line
set statusline=
set statusline +=%1*\ %n\ %*    "buffer number
set statusline +=%4*\ %<%f%*    "full path
set statusline +=%2*%m%*        "modified flag
set statusline +=%1*%=%5l%*     "current line
set statusline +=%2*/%L%*       "total lines
set statusline +=%1*%4v\ %*     "virtual column number
"set statusline +=%1*\ %f%*
"set statusline +=\ %l
"set statusline +=\ %L
"set statusline +=\ %n

colorscheme mevening  " the color scheme

"" Limit matchparens timeout
"let g:matchparen_timeout = 5
"let g:matchparen_insert_timeout = 1
let g:loaded_matchparen = 0

"""" Functions 
"" Trim trailing whitespace from all lines
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun

"" Fix spacing around assignemts, a=b -> a = b
fun! SpaceAssign()
    let l:save = winsaveview()
    %s/\([a-zA-Z0-9_]\)=\([a-zA-Z0-9_]\)/\1\ =\ \2/g
    call winrestview(l:save)
endfun

"" Enable syntax highlighting for ext
fun! SyntaxOn(ext, type)
    execute "au BufNewFile,BufRead *." . a:ext . " set filetype=" . a:type
endfun

"""" Plugin specific configs 
let g:fzf_layout = { 'down': '~30%'}
"let g:fzf_commits_log_options = '--graph --color=always --all --pretty=tformat:"%C(auto)%h%d %s %C(green)(%ar)%Creset %C(blue)<%an>%Creset"'

"" This controls :Files not :Rg
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --follow -g'!.git/*'"

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* Rgi
  \ call fzf#vim#grep(
  \   'rg --column --line-number -i --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

"" Use sql syntax highlighting for *.sqli files
call SyntaxOn('sqli', 'sql')

"" Use cpp syntax highlighting for *.inc files
call SyntaxOn('inc',  'cpp')

autocmd VimEnter * CSApprox

"""" Snippets
function! _snippets()

"" Change pushInputEvent(()) to pushInputEvent()
%s/pushInputEvent((\(.\{-}\)))/pushInputEvent(\1)
%s/pushOutputValidator((\(.\{-}\)))/pushOutputValidator(\1)

"" Rearrange const, & in the output has to be escaped since it inserts the
"" entire matched pattern
%s/const \(.\{-}\) &/\1 const \& /gc

endfunction
