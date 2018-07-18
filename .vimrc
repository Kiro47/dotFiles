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

"Auto install PDF to text
function! InstallPdfToText(info)
	if empty(glob('~/.vim/PDF_To_Text/installer.run'))
		silent !curl -fLo ~/.vim/PDF_To_Text/installer.run --create-dirs
		\ https://xpdfreader-dl.s3.amazonaws.com/XpdfReader-linux64-4.00.01.run
		chmod u+x ~/.vim/PDF_To_Text/installer.run
		"Note, stupid thing always does relative install
		autocmd VimEnter * ~/.vim/PDF_To_text/./installer.run
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

" Inbuilt file manager with git extension
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Git Change Notifier
Plug 'airblade/vim-gitgutter'

" Git Wrapper
Plug 'tpope/vim-fugitive'

" Hex -> CSS Color Selector
Plug 'ap/vim-css-color'

"CSS 3 Syntax Highlighting
Plug 'hail2u/vim-css3-syntax'

"CSS 3 Syntax Highlighting
Plug 'cakebaker/scss-syntax.vim'

" C++ Extra highlighting
Plug 'octol/vim-cpp-enhanced-highlight'

" Snippet Marker
Plug 'SirVer/ultisnips'

" Snippet Templates
Plug 'honza/vim-snippets'

" Status Bar
Plug 'vim-airline/vim-airline'

" Status Bar Themes
Plug 'vim-airline/vim-airline-themes'

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

" Async Lint Engine
if v:version > 800
	Plug 'w0rp/ale'
endif

" Auto tab formatting
Plug 'godlygeek/tabular'

" Vim PDF Reader so Baron stops making me feel bad.
Plug 'makerj/vim-pdf', {'do': function('InstallPdfToText') }

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
"set expand tab "Depends on which system, sometimes this is mandatory off
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
set hlsearch " highlight all matches

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
"set mouse=a

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

" CSS 3 Highlight rig
augroup VimCSS3Syntax
autocmd!

autocmd FileType css setlocal iskeyword+=-
augroup END

" CSS 3 keyword fix
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

" ALE config
let g:ale_completion_enabled = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" Disable highlighting let g:ale_set_highlights = 0
let g:ale_list_window_size = 5
" ALE airline integration
let g:airline#extensions#ale#enabled = 1

" Airline theme
let g:airline_theme='hybridline'

"Auto remove trailing white space
autocmd BufWritePre * :%s/\s\+$//e

" MTU formatting spec
autocmd Filetype cfg setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal  ts=2 sts=2 sw=2
autocmd Filetype puppet setlocal  ts=2 sts=2 sw=2
autocmd Filetype yaml setlocal  ts=2 sts=2 sw=2
autocmd BufNewFile,BufRead *.epp set filetype=eruby
autocmd FileType make set noexpandtab sw=8 sts=0

" Enable spellcheck
" use z= to find suggestions
" use zg to add to dictionary
set spelllang=en
set spell
