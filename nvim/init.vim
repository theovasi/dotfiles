" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Plug 'chriskempson/base16-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
" Devicons
Plug 'ryanoasis/vim-devicons'
" SimplyFold
Plug 'tmhedberg/SimpylFold'
" NerdTree
Plug 'scrooloose/nerdtree'
" NerdCommenter
Plug 'scrooloose/nerdcommenter'
" SuperTab
Plug 'ervandew/supertab'
" Git Gutter
Plug 'airblade/vim-gitgutter'
" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code completion
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Lint
Plug 'w0rp/ale'

" JS syntax highlighting
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Auto expand HTML tags
Plug 'mattn/emmet-vim'

" Multiple selections
Plug 'terryma/vim-multiple-cursors'

" Run SHELL commands asynchronously
Plug 'skywind3000/asyncrun.vim'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Initialize plugin system
call plug#end()

" Confiure airline
let g:airline_theme='tomorrow'

" Required:
filetype indent plugin on
set tabstop=4
autocmd FileType javascript :setlocal sw=2 ts=2 sts=2
set shiftwidth=4
set expandtab
set noswapfile
map <Tab> :tabn<CR>

" Configure colorscheme
" colorscheme base16-default-dark
set t_Co=256
syntax on
" colorscheme base16-default-dark
color Tomorrow-Night-Eighties
set number
set cursorline

" Configure NerdTree
nnoremap <LocalLeader>f :NERDTreeToggle<CR>
let NERDTreeMapOpenInTab='t'
let NERDTreeQuitOnOpen=1
let NERDTreeMapActivateNode='<l>'
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Configure NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Configure deoplete
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
let g:SuperTabDefaultCompletionType = "<c-n>"

" Configure ALE
 let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 1
 let g:ale_fixers = {
 \   'python': ['autopep8'],
 \}
 let g:ale_linters = {
\   'javascript': ['eslint'],
\   'jsx': ['stylelint', 'eslint']
\}

let g:ale_fix_on_save = 1
highlight ALEErrorSign guibg=#ff5555 guifg=#ff5555
highlight ALEWarningSign guibg=#f1fa8c guifg=#f1fa8c
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Emmet configuration
let g:user_emmet_leader_key='<Tab>'
let g:user_emmet_settings = {
  \  'javascript.jsx' : {
    \      'extends' : 'jsx',
    \  },
  \}

" Autoformat JS code on save.
autocmd BufWritePost *.js AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
