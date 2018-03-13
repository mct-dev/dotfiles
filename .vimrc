if (has("termguicolors"))
  set termguicolors
endif

" Set compatibility to Vim only.
set nocompatible
" Encoding
set encoding=utf-8

" Helps force plug-ins to load correctly when it is turned back on below.
filetype on
" tell vim it's ok to use 256 colors at terminal
set t_Co=256

" Turn on syntax highlighting.
syntax enable
" theme/color stuff
set background=dark

" Automatically wrap text that extends beyond the screen length.
set nowrap

" tab completion of filenames
set wildmenu

" turn off mouse when typing begins
set mousehide

" Status Line
" ------------
" %< means truncate on the left if too long
" %F is full path to the file we are editing
set statusline=%<%F

" %m shows [+] if the file is modified but not saved
set statusline+=%m

" %r shows [RO] if a file is read-only
set statusline+=%r

" %h shows [Help] if we are in a help buffer
set statusline+=%h

" %w shows [Preview] if we are in a preview window
set statusline+=%w

" separation point between the left and right items
set statusline+=%=

" prints the fileformat; that is, the kind of newline (one of unix, dos or
" mac)
" (If you type `:set fileformat?`, vim will tell you the current file
" format)
set statusline+=%{&fileformat}

" a literal forward slash
set statusline+=/

" %Y shows the filetype, such as VIM or HTML or GO
set statusline+=%Y

" %l shows the line number, and %8l uses 8 left-padded spaces to do so
set statusline+=%8l

" a literal comma
set statusline+=,

" %v shows the virtual column number;
" instead of counting a tab as one char, it counts it as the number
" of spaces it uses in the display
" %-8v leaves 8 spaces to the right to do so
set statusline+=%-8v

" disable recording macros: I hit this key accidentally too often
nnoremap q <Nop>
 
" Turn off modelines
set modelines=0

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump
" between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Show line numbers
set number

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text,
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
" vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

" lint on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_chaned=0
" enable flow
let g:javascript_plugin_flow=1
" jsx extension not required
let g:jsx_ext_required=0

" change slit window focus keybinds
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" set more natural split behavior
set splitbelow
set splitright

" toggle nerdtree
noremap <Leader>t :NERDTreeToggle<CR>

" airline show buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'

" nerdtree
" let NERDTreeShowHidden=1

" emoji stuff
set completefunc=emoji#complete

" let mapleader=","

" VimWiki stuff
let wiki = {}
let wiki.path = '~/vimwiki/'
let wiki.nested_syntaxes = {'javascript':'javascript', 'python':'python'}
let g:vimwiki_list = [wiki]

" colorscheme MUST go at the end to make sure it doesn't get 
" overwritten by something else.
colorscheme solarized8_flat 

if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  set t_ut=
endif
