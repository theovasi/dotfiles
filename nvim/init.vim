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

"Python lint
NeoBundle 'w0rp/ale'
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
NeoBundle 'Valloric/YouCompleteMe', {  
     \ 'build'      : {
        \ 'mac'     : './install.sh --clang-completer --system-libclang --omnisharp-completer',
        \ 'unix'    : './install.sh --clang-completer --system-libclang --omnisharp-completer',
        \ 'windows' : './install.sh --clang-completer --system-libclang --omnisharp-completer',
        \ 'cygwin'  : './install.sh --clang-completer --system-libclang --omnisharp-completer'
        \ }
     \ }

" Syntax highlighting
NeoBundle 'python-mode/python-mode'

call neobundle#end()  
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck  
"End NeoBundle Scripts-------------------------
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

let g:ycm_autoclose_preview_window_after_insertion = 1

" Configure appearence
set t_Co=256
let g:rehash256 = 1
colorscheme molokai
hi Normal ctermbg=NONE
hi NonText ctermbg=NONE
hi LineNr ctermbg=NONE

" Configure NerdTree
map <F3> :NERDTreeToggle<CR>
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
