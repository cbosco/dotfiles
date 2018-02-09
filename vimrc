" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'editorconfig-vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'ragtag.vim'
Plugin 'surround.vim'
Plugin 'Syntastic'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Make vim more useful
set nocompatible

" Turn on 256 colors
"set t_Co=256
set t_Co=16
" Turn out the lights
set background=dark
syntax on
colorscheme molokai

" Change mapleader
let mapleader=" "

set autoread " Set to auto read when a file is changed from the outside
set showmode " Show mode in bottom of window
set matchpairs+=<:> " Add XML style elements to matching
set backspace=indent,eol,start
set cursorline " Highlight current line
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set encoding=utf-8 nobomb " BOM often causes trouble
set esckeys " Allow cursor keys in insert mode.
set ruler " Show cursor location
set magic "Set magic on, for regular expressions
set noerrorbells " Disable error bells.
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command.
set nostartofline " Don't reset cursor to start of line when moving around.
set nu " Enable line numbers.
set nosmarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces.
"set undofile " Persistent Undo.
set showmatch "Show matching bracets when text indicator is over them
set guicursor+=a:blinkon0
set visualbell t_vb= " turn off the bell

" Indenting
set autoindent " Copy indent from last line when starting new line
set smarttab " Indent further in or out based on previous line
set tabstop=4 " Set tab stop to 4
set shiftwidth=4 " Set shift width to 4
set expandtab

" searching
set hlsearch " Highlight searches
set incsearch " Highlight dynamically as pattern is typed.
set ignorecase " Ignore case of searches.
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters.

" Show special characters
:set listchars=tab:>-,trail:~,extends:>,precedes:<
:set list

"" directories
"" set backup locations and enable
"set backup
"set backupdir=~/.backup
"set directory=~/.backup
"set undodir=~/.undo

" Sudo write (<leader>W)
noremap <leader>W :w !sudo tee %<CR>

" Trigger NERDTree
noremap <leader>n :NERDTree<CR>

" Remap typos :W to :w
if has("user_commands")
    command! -bang -nargs=? -complete=file E e<bang> <args>
    command! -bang -nargs=? -complete=file W w<bang> <args>
    command! -bang -nargs=? -complete=file Wq wq<bang> <args>
    command! -bang -nargs=? -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
endif

" Indent/unident block (<leader>]) (<leader>[)
nnoremap <leader>] >i{<CR>
nnoremap <leader>[ <i{<CR>

" Vim on the iPad
if &term == "xterm-ipad"
  nnoremap <Tab> <Esc>
  vnoremap <Tab> <Esc>gV
  onoremap <Tab> <Esc>
  inoremap <Tab> <Esc>`^
  inoremap <Leader><Tab> <Tab>
endif

" Strip trailing whitespace (<leader>ss)
function! StripWhitespace ()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace ()<CR>

noremap <C-c> <Esc>
noremap! <C-c> <Esc>

" Dvorak movement, everything is fine except L (move to Dvorak S)
noremap s l
noremap <C-W>s <C-W>l

" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
if exists('+colorcolumn')
    set colorcolumn=100
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
endif

" Paste mode
" set paste

" Syntastic

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['handlebars']

" Override eslint with local version where necessary.
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
  let g:syntastic_javascript_eslint_exec = local_eslint
endif

" vim-jsx
let g:jsx_ext_required = 0 " not just .jsx files
