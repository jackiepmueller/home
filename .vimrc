"""" HOW TO USE
" 1. Select a profile from the PROFILES section by uncommenting its lines and
"    commenting-out the lines of the other profiles.
" 2. Add a user profile entry to the USERS section if you want to make any
"    changes to the default settings.
" 3. If you have a different tabs-to-spaces setting (other than 4), add
"    another profile to the PROFILES section instead of modifying one.


"""" TIPS
" - paste multiple lines without vim mangling them
"     set paste
"     <insert lines>
"     set nopaste
" - convert tabs to spaces (according to the settings in this file)
"     retab


"""" COMMON SETTINGS
set nocompatible                " vim defaults, not vi
filetype off                  " required
set t_Co=256

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'Valloric/YouCompleteMe'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
Plugin 'user/L9', {'name': 'newL9'}
" Switching between header and source files
Plugin 'vim-scripts/a.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on              " enable filetypes and plugins

let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"" General
"set textwidth=78                           " screen in 80 columns wide, wrap at 78
set autoindent smartindent                 " smarter indent behavior
autocmd FileType make setlocal noexpandtab " Don't insert spaces for makefiles
set smarttab                               " make tab and backspace smarter
set nowrap                                 " don't wrap long lines
set number                                 " display line numbers
set relativenumber                         " display relative line numbers
set hidden                                 " allow switching buffers without saving
set hlsearch                               " highlight search matches
set backspace=indent,eol,start             " allow backspace over indent, eol, start
set formatoptions=tcqlron                  " auto-wrap lines/comments at textwidth,
                                           " allow formatting using gq commands,
                                           " long lines not broken in insert mode
                                           " auto-insert comment leader on Enter or O,
                                           " recognize numbered lists
set directory=~/.vim/swapfiles//

"" Syntax
syntax on                       " enable syntax highlighting
set foldmethod=syntax           " syntax-based code folding
set nofoldenable                " disable folding (enable in USERS section)
set cinoptions=:0,l1,t0,g0      " case labels at column 0,
                                " align line after case label with label,
                                " return type declaration at column 0,
                                " c++ scope declarations at column 0

"" Shortcuts
" forces (re)indentation of a block of code
nmap <c-j> vip=
" scroll forward one screen
nmap <space> <c-f>
" scroll backward one screen
nmap <bs> <c-b>
" cycle between split windows
nmap - <c-w>w
" toggle search highlighting
nmap th :set hlsearch!<cr>
" toggle code folding
nmap tf :set foldenable!<cr>
" toggle line wrapping
nmap tw :set wrap!<cr>
" toggle numbering
nmap tn :set number!<cr>
" rebuild python
nmap prb :!python setup.py install --prefix=~<cr>
" default s seems eclipsed by c functionality. instead mapping s to 'insert
" one char and stay in normal mode'
nnoremap s :exec "normal i".nr2char(getchar())."\e"<CR>
nnoremap S :exec "normal a".nr2char(getchar())."\e"<CR>
" YouCompleteMe GoTo
nmap <F3> :YcmCompleter GoTo<CR>

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

"" Statusline
set laststatus=2 " Always show status line
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%4*\ %<%f%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number

colorscheme mevening  " the color scheme

"let g:loaded_youcompleteme = 1  "Disable youcompleteme
