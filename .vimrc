if has('vim_starting')
    if &compatible
        set nocompatible
   endif

   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Плагины
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'vim-perl/vim-perl'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'vim-scripts/javacomplete'
NeoBundle 'shawncplus/phpcomplete.vim'
NeoBundle 'groenewege/vim-less'
NeoBundle 'ervandew/supertab'
NeoBundle 'klen/python-mode'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'dag/vim2hs'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'cakebaker/scss-syntax.vim'
"NeoBundle 'Shougo/vimproc.vim', {'build' : {'linux': 'make'}}
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'tpope/vim-surround'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'Dimercel/todo-vim'

NeoBundle 'xolox/vim-reload'
NeoBundle 'xolox/vim-misc'
NeoBundle 'vim-scripts/xoria256.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" Список кодировок файлов для автоопределения
set fileencodings=utf-8,cp1251,koi8-r,cp866,latin1

set ff=unix

syntax on

set t_Co=256

colorscheme xoria256

" настройка вида курсора
let &t_SI = "\<Esc>]12;orange\x7"
let &t_EI = "\<Esc>]12;white\x7"
silent !echo -ne "\033]12;white\007"
autocmd VimLeave * silent !echo -ne "\033]12;white\007"

set showmatch
set autoread
set lazyredraw
set cursorline
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ for\ Powerline\ 10 "устанавливаем шрифт
"set smartindent " Automatically indent when adding a curly bracket, etc.
set incsearch " переход к искомому слову во время печати этого слова
set guioptions-=T " убираем тулбар
set guioptions-=r " убираем scrollbar
set lcs=tab:▶•,trail:•,eol:¬,nbsp:% " подстановка непечатаемых символов

" Размеры табуляции и отступов
set autoindent
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set smartcase
set ignorecase
set nowrap
set title " показывать имя буфера в заголовке терминала
set history=256 " хранить больше истории команд
set undolevels=2048 " хранить историю изменений числом N
set number
set list!

filetype plugin on
set ofu=syntaxcomplete#Complete
set cot-=preview "disable doc preview in omnicomplete
set nocp
set hidden


au BufWinLeave *.* silent mkview " при закрытии файла сохранить 'вид'
au BufWinEnter *.* silent loadview " при открытии - восстановить сохранённый

set backspace=indent,eol,start " backspace обрабатывает отступы, концы строк
:autocmd BufEnter * lcd %:p:h " переходить в каталог текущего файла автоматически

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

autocmd vimenter * NERDTree " Вызываем плагин дерева
let g:pymode_lint = 0

set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" нормальные регулярки
nnoremap / /\v
vnoremap / /\v


" Настройки плагинов
" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1

" NERDTree
let g:NERDTreeShowBookmarks=1
let g:NERDChristmasTree=1

" airline
let g:airline_theme='light'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_linecolumn_prefix = '¶ '
let g:airline_paste_symbol = 'ρ'

let g:airline_extensions = ['branch', 'syntastic', 'tagbar', 'hunks']

" todo-vim
let g:todo_winheight = 20

let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets/xolcman'

" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

" Пользовательские функции
function! g:AutoReadOnly()
    if matchstr(bufname("%"), "\\.ro$") != ''
        setlocal readonly
    endif

endfunction

autocmd BufEnter * call g:AutoReadOnly()


" Пользовательские сочетания клавиш
map <C-h> ^
map <C-l> $
nmap <F2> :NERDTreeToggle<CR>
nmap <F3> :GundoToggle<CR>
nmap <F4> :set hlsearch! hlsearch?<CR>
nmap <F8>  :TagbarToggle<CR>
nmap <silent> <Bslash><Bslash> :Unite buffer file<CR>
nmap <leader>nh :GitGutterNextHunk<CR>
nmap <leader>ph :GitGutterPrevHunk<CR>
imap <c-space> <c-x><c-o>
map <leader>e <C-Y>,
nmap <leader>cp :CtrlPCmdPalette<CR>
map <leader>x "+x
map <leader>y "+y
map <leader>p "+gP
nmap <leader>w+ <C-W>_
nmap <leader>w- <C-W>1_
nmap <leader>w> <C-W><Bar>
nmap <leader>w< <C-W>1<Bar>
nmap <F5> 4<C-W>>
nmap <S-F5> 4<C-W><
nmap <F6> 4<C-W>+
nmap <S-F6> 4<C-W>-
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
nmap <leader>t :TODOOpen<CR>
map <Up>   <C-W>k
map <Down> <C-W>j
map <Left> <C-W>h
map <Right> <C-W>l
