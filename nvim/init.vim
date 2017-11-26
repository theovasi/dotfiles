
" NeoBundle Scripts-----------------------------
if has('vim_starting')
  set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
  set runtimepath+=~/.config/nvim/
endif

let neobundle_readme=expand('~/.config/nvim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)  
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.config/nvim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.config/nvim/bundle/neobundle.vim/
  let g:not_finsh_neobundle = "yes"
endif

call neobundle#begin(expand('$HOME/.config/nvim/bundle'))  

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

""" Colorscheme Approximation """
" This transforms colorschemes to terminal colorschemes
" The ctermbg=NONE hooks make backgrounds transparent in terminals
NeoBundle 'godlygeek/csapprox'
let g:CSApprox_hook_post = [
            \ 'highlight Normal            ctermbg=NONE',
            \ 'highlight LineNr            ctermbg=NONE',
            \ 'highlight SignifyLineAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifyLineDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifyLineChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignifySignAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifySignDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifySignChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignColumn        ctermbg=NONE',
            \ 'highlight CursorLine        ctermbg=NONE cterm=underline',
            \ 'highlight Folded            ctermbg=NONE cterm=bold',
            \ 'highlight FoldColumn        ctermbg=NONE cterm=bold',
            \ 'highlight NonText           ctermbg=NONE',
            \ 'highlight clear LineNr'
            \]



" SimplyFold
NeoBundle 'tmhedberg/SimpylFold'
" NerdTree
NeoBundle 'scrooloose/nerdtree'
" NerdCommenter
NeoBundle 'scrooloose/nerdcommenter'
" SuperTab
NeoBundle 'ervandew/supertab'
" Git Gutter
NeoBundle 'airblade/vim-gitgutter'
" Airline
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
let g:airline_theme='powerlineish'

" Code completion
NeoBundle 'zchee/deoplete-jedi'
NeoBundle 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Lint
NeoBundle 'w0rp/ale'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 1
let g:ale_fixers = {
\   'python': ['autopep8'],
\}
let g:ale_fix_on_save = 1

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Configure appearence
set t_Co=256
let g:rehash256 = 1
colorscheme molokai
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE
hi LineNr ctermbg=NONE

" Configure NerdTree
nnoremap <LocalLeader>t :NERDTreeToggle<CR>
map <Tab> :tabn<CR>

let NERDTreeMapActivateNode='<l>'

" Configure NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" PEP8 code formatting
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>

" Auto import sorting
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
