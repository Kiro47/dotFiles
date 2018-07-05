"YouComplete Me Plugin Build Script
function! BuildYCM(info)
" info is a dictionary with 3 fields
" - name:   name of the plugin
" - status: 'installed', 'updated', or 'unchanged'
" - force:  set on PlugInstall! or PlugUpdate!
if a:info.status == 'installed' || a:info.force
!./install.py --clang-completer --go-completer --java-completer
endif
endfunction

" Auto Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugin Load -> vim-plug
call plug#begin('~/.vim/plugged')

" You Complete Me (God tier plugin)
if v:version > 800
	Plug 'Valloric/YouCompleteMe', {'do': function('BuildYCM') }
endif

" Inbuild file manager with git extension
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git Change Notifier
Plug 'airblade/vim-gitgutter'

" Git Wrapper
Plug 'tpope/vim-fugitive'

" Hex -> CSS Color Selector
Plug 'ap/vim-css-color'

"CSS3 Syntax Highlighting
Plug 'hail2u/vim-css3-syntax'

"CSSS3 Syntax Highlighting
Plug 'cakebaker/scss-syntax.vim'

" C++ Extra highligthing
Plug 'octol/vim-cpp-enhanced-highlight'

" Snippet Marker
Plug 'SirVer/ultisnips'

" Snippet Templates
Plug 'honza/vim-snippets'

" Status Bar
Plug 'bling/vim-airline'

" Tab Completion Searching
Plug 'vim-scripts/SearchComplete'

"SQL Completion
Plug 'vim-scripts/SQLComplete.vim'

" Syntax Checker
Plug 'tomtom/checksyntax_vim'

" Puppet
Plug 'rodjek/vim-puppet'

" Puppet Labs syntax
Plug 'puppetlabs/puppet-syntax-vim'


call plug#end()
"Plugin Calling Ends

"General Formatting
set guifont=Monospace\ 12
filetype indent plugin on
syntax enable
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab "Depends on which system, sometimes this is mandatory off
set number
set ruler
set encoding=utf-8
set smartindent
set showcmd
set cursorline

"Search Modifiers
set ignorecase
set smartcase
set incsearch " dynamic searching
set hlsearch " hightlight all matches

" NO BEEP DEAR GOD WHO THOUGHT THIS WAS A GOOD IDEA?
set noerrorbells
set visualbell
set t_vb=

" Cache
set tabpagemax=100
set history=500


" Navigation Mapping
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Hot Swap backup modifier
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" Enable Mouse support
set mouse=a

"Color Formatting
colorscheme koehler

"Column 80 mod
highlight ColorColumn ctermbg=magenta
call matchadd('colorColumn','\%81v',100)

"File specific
filetype on
filetype plugin indent on
autocmd FileType c,cpp,slang set cindent

" You Complete Me config Pull
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

"NERD Tree
map <C-t> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

"  Git Wrapper
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 1
let g:gitgutter_highlight_lines = 0
set updatetime=100

" CSS3 Hightlight rig
augroup VimCSS3Syntax
autocmd!

autocmd FileType css setlocal iskeyword+=-
augroup END

" CSSS3 keyword fix
autocmd FileType scss set iskeyword+=-
au BufRead,BufNewFile *.scss set filetype=scss.css

" Fix backspace issue on VIM 8+
if v:version > 800
	set backspace=indent,eol,start
endif

" C++ Configuration
let c_no_curly_error=1
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

"Snippets
let g:UltiSnipsExpandTrigger="<C-TAB>"
let g:UltiSnipsJumpForwardTrigger="<A-ENTER>"
let g:UltiSnipsJumpBackwardTrigger="<A-BACKSPACE>"
