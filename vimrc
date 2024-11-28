set nocompatible
"let g:lsp_diagnostics_enabled = 0
let g:polyglot_disabled = ['autoindent']
" Plugin
call plug#begin()
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'lervag/vimtex'

Plug 'sheerun/vim-polyglot'
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

augroup CustomEverforestHighlighting
    autocmd!
    autocmd ColorScheme everforest call everforest#highlight('MatchParen', ['#2B3339', '235'], ['#E69875', '173'], 'bold')
augroup END

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

" tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_keepdir = 0
let g:netrw_winsize = 20

" remove unnecessary gui elements
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=l
set guioptions-=L

" setting for moving lines
nnoremap <a-j> :m .+1<cr>==
nnoremap <a-k> :m .-2<cr>==
inoremap <a-j> <esc>:m .+1<cr>==gi
inoremap <a-k> <esc>:m .-2<cr>==gi
vnoremap <a-j> :m '>+1<cr>gv=gv
vnoremap <a-k> :m '<-2<cr>gv=gv

set cursorline
" setting for vim-lsp
set nocompatible

command! EnableDiagnostics :call lsp#enable_diagnostics_for_buffer(bufnr('%'))
command! DisableDiagnostics :call lsp#disable_diagnostics_for_buffer(bufnr('%'))
augroup AutoDisableDiagnostics
    autocmd!
    autocmd BufRead,BufNewFile * :call lsp#disable_diagnostics_for_buffer(bufnr('%'))
augroup END

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
	
	let g:lsp_diagnostics_signs_insert_mode_enabled = 0
	let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
	let g:lsp_diagnostics_float_cursor = 1
	let g:lsp_diagnostics_echo_cursor = 1
	let g:lsp_document_code_action_signs_enabled = 0
	let g:lsp_diagnostics_virtual_text_enabled = 1
	let g:lsp_completion_documentation_delay = 0
	let g:lsp_diagnostics_float_insert_mode_enabled = 0
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

let g:vimtex_view_general_viewer = 'SumatraPDF'
let g:vimtex_view_general_options
                \ = '-reuse-instance -forward-search @tex @line @pdf'
set autoindent
set spell
set is
set ruler
set ignorecase
set smartcase
set gp=git\ grep\ -n
set laststatus=0
command! MyPlugClean    :set shell=cmd.exe shellcmdflag=/c noshellslash guioptions-=! <bar> noau PlugClean
packadd! matchit
command! CopyFilePath :let @+ = expand("%:p") "\<cr>"
command! CopyDirPath :let @+ = expand("%:p:h") "\<cr>"
command! CopyFileName :let @+ = expand("%:t") "\<cr>"
nnoremap cpf i#include<iostream><Esc>ousing namespace std;<Esc>o<CR>int main(){<Esc>o<Esc>oreturn 0;<Esc>o}<Esc>kki
inoremap <c-q> <Esc>:Lex<cr>
nnoremap <c-q> :Lex<cr>
set scrolloff=5
