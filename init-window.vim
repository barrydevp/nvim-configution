" Plugins with vim.plug
call plug#begin('~/.config/nvim/plugged')

" useful
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'
Plug 'sheerun/vim-polyglot'

" theme
Plug 'dracula/vim', { 'as': 'dracula' }

" status bar
Plug 'itchyny/lightline.vim'

" directory, file explorer
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" git tool
Plug 'tpope/vim-fugitive'

" completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fast typing
Plug 'jiangmiao/auto-pairs' " Auto close
Plug 'tpope/vim-surround' " Handle pairs
Plug 'tpope/vim-repeat' " Enhance dot commands
Plug 'tpope/vim-commentary' " Code comments

"" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" javascript and jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" c
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" python
"" Python Bundle
Plug 'davidhalter/jedi-vim'
Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}

" rust
" Vim racer
Plug 'racer-rust/vim-racer'

" Rust.vim
Plug 'rust-lang/rust.vim'


" typescript
Plug 'leafgarland/typescript-vim'
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

" Some prePlugin configuration


" Basic configuration

syntax on
set ruler               " Show the line and column numbers of the cursor.
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.
set showcmd                     " Show me what I'm typing
set encoding=utf-8              " Set default encoding to UTF-8
set showmatch                   " Do not show matching brackets by flickering
set incsearch                   " Shows the match while typing
set hlsearch                    " Highlight found searches
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters
set autoindent
set tabstop=4 shiftwidth=4 expandtab
set confirm
set wildmenu
set mouse=a
set textwidth=80

"" Copy/Paste/Cut
set clipboard=unnamed
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

set relativenumber
set number
set cursorline

" Terminal configuration
" open new split panes to right and below
set splitright
set splitbelow
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Plugin configuration

" dracula
"syntax enable
colorscheme dracula
if (has("termguicolors"))
 set termguicolors
endif
syntax enable
colorscheme dracula

" lightline
set noshowmode
highlight clear CursorLine " Removes the underline causes by enabling cursorline

let g:python3_host_prog='C:\Users\fieub\AppData\Local\Programs\Python\Python38-32\python3.exe'
let g:python_host_prog='C:\Python27\python.exe'

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'cwd' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ]
  \     ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \     'cocstatus': 'coc#status',
  \     'filename': 'LightlineFilename',
  \     'cwd': 'LightlineCwd',
  \   }
  \ }
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

function! LightlineCwd()
  return getcwd(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" NERDTree
let NERDTreeShowHidden = 1
let NERDTreeDirArrows = 1
let NERDTreeHijackNetrw = 1
map <C-g> :NERDTreeToggle<CR>

" Nerd tree highlighting
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHightlightFullName = 1
let NERDTreeIgnore=['.DS_Store', '\.git']

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" Ctrlp
" let 

" Coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"
"
" -----MAPPINGs--------------
"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" ----------------------------WINDOW-----------------------

let g:go_auto_type_info = 1

let g:go_fmt_command = "goimports"

set omnifunc=syntaxcomplete#Complete
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
