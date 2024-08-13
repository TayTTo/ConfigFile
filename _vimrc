" Plugin
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'sainnhe/everforest'

Plug 'mattn/emmet-vim'
call plug#end()

" Important!!
if has('termguicolors')
  set termguicolors
endif

" For light version.
set background=light

" Set contrast.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'

" For better performance
let g:everforest_better_performance = 1

colorscheme everforest

let g:airline_powerline_fonts = 1
let g:airline_theme = 'everforest'
let g:airline_detect_modified=1
let g:airline_detect_crypt=0
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
let g:airline_section_y=0
let g:airline_section_error=0
let g:airline_section_warning=0
"let g:airline_experimental = 1
"let g:airline_inactive_collapse=1
"let g:airline_inactive_alt_sep=1

let g:everforest_cursor = 'blue'
let g:everforest_colors_override = {'bg_visual': ['#CCE5FF', '255'], }
set number relativenumber
syntax enable
set background=light
filetype plugin indent on

set noswapfile
set tabstop=4
set shiftwidth=4
set termguicolors

set path+=**

set shell=pwsh
set wildmenu
set hidden
set wildignore=*.exe,*.dll,*.pdb
set backspace=2
set guifont=JetBrainsMono_NFM:h12:cANSI:qDRAFT

" Setting terminal's color
let g:terminal_ansi_colors = [
    \ '#fdf6e3', '#dc322f', '#859900', '#b58900',
    \ '#268bd2', '#d33682', '#2aa198', '#657b83',
    \ '#ffa07a', '#cb3b16', '#8da101', '#dfa000',
    \ '#839496', '#6c71c4', '#93a1a1', '#002b36']

highlight Terminal guibg='#fdf6e3' guifg='#657b83'
"hi Directory ctermfg='#fdf6e3'
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
"let g:netrw_browse_split=4  " open in prior window
"let g:netrw_altv=1          " open splits to the right
"let g:netrw_liststyle=3     " tree view
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_keepdir = 0
let g:netrw_winsize = 30

" Remove unnecessary GUI elements
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=l
set guioptions-=L

" Setting for moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

set cursorline

" Setting for vim-lsp
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=no
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

	let g:lsp_diagnostics_enalbled = 0
    let g:lsp_format_sync_timeout = 1000
	let g:lsp_diagnostics_float_cursor = 1
	let g:lsp_diagnostics_echo_cursor = 1
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

"Auto popup
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

set autoindent
set spell
set is
set ruler
set ignorecase
set smartcase
set gp=git\ grep\ -n
packadd! matchit

