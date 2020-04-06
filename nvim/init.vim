if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" List pluging for vim-plug to install
call plug#begin('~/.local/share/nvim/plugged')

" Bundle of base-16 themes Plug 'chriskempson/base16-vim'
Plug 'chriskempson/base16-vim'
Plug 'dracula/vim'

" Status line of choice
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Nice side menu for browsing files
Plug 'preservim/nerdtree'

call plug#end()

syntax on
filetype indent plugin on

" Editor behaviour
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set number
set cursorline
set noswapfile
set noshowmode
map <Tab> :tabn<CR>

" Colorscheme configuration
let base16colorspace=256  " Access colors present in 256 colorspace
set termguicolors
colorscheme dracula
hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
hi CursorLineNr guibg=#1d1f21 guifg=#50fa7b
hi CursorLine guibg=#1d1f21

" Pluging configuration

" Airline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='venom'

" Nerdtree
map <C-f> :NERDTreeToggle<CR>
