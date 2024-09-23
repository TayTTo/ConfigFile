" Plugin
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'sainnhe/everforest'

Plug 'mattn/emmet-vim'
call plug#end()

" For light version.
set background=light

" Set contrast.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'medium'

" For better performance
let g:everforest_better_performance = 1

colorscheme everforest


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
set noswapfile

" Setting terminal's color
let g:terminal_ansi_colors = [
    \ '#fdf6e3', '#dc322f', '#859900', '#b58900',
    \ '#268bd2', '#d33682', '#2aa198', '#657b83',
    \ '#ffa07a', '#cb3b16', '#8da101', '#dfa000',
    \ '#839496', '#6c71c4', '#93a1a1', '#002b36']

highlight Terminal guibg='#fdf6e3' guifg='#657b83'

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
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

	let g:lsp_diagnostics_enalbled = 1
	let g:lsp_diagnostics_virtual_text_enabled = 1
	let g:lsp_format_sync_timeout = 1000
	let g:lsp_diagnostics_float_cursor = 1
	let g:lsp_diagnostics_echo_cursor = 1
	let g:lsp_completion_documentation_delay = 0
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
set laststatus=0
set so=10 
command! MyPlugClean    :set shell=cmd.exe shellcmdflag=/c noshellslash guioptions-=! <bar> noau PlugClean
packadd! matchit
command! CopyFilePath :let @+ = expand("%:p") "\<cr>"
command! CopyDirPath :let @+ = expand("%:p:h") "\<cr>"
command! CopyFileName :let @+ = expand("%:t") "\<cr>"
":call lsp#disable_diagnostics_for_buffer(bufnr('%'))
command! EnableDiagnostics :call lsp#enable_diagnostics_for_buffer(bufnr('%'))
command! DisableDiagnostics :call lsp#disable_diagnostics_for_buffer(bufnr('%'))
