

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

execute pathogen#infect()
autocmd vimenter * NERDTree

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme molokai
let g:molokai_orignal = 1
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set number
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Moving through tabs
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

"Automatically adding comments section
function FileHeading()
  let s:line=line(".")
  call setline(s:line,"/**")
  exe 'normal! ' . "o"
  call append(s:line+1," * @file .c ")
  call append(s:line+2," * @author Siddharth Shah")
  call append(s:line+3," * @date ".strftime("%b %d %Y"))
  call append(s:line+4," * @brief Brief description of file")
  call append(s:line+5," * ")
  call append(s:line+6," */ ")
  unlet s:line
endfunction

nmap 1 <Esc>mz:execute FileHeading()<CR>`zjA

"Automatically adding comments section
function FunctionHeading()
  let s:line=line(".")
  call setline(s:line,"/**")
  exe 'normal! ' . "o"
  call append(s:line+1," * Function: ")
  call append(s:line+2," * ")
  call append(s:line+3," * Input: ")
  call append(s:line+4," * ")
  call append(s:line+5," * Output: ")
  call append(s:line+6," * ")
  call append(s:line+7," * Description: ")
  call append(s:line+8," * ")
  call append(s:line+9," */")
  unlet s:line
endfunction

nmap 2 <Esc>mz:execute FunctionHeading()<CR>`zjA

"Automatically adding comments section
function FunctionHeadingPersonal()
  let s:line=line(".")
  call setline(s:line,"/**")
  exe 'normal! ' . "o"
  call append(s:line+1," * Function: ")
  call append(s:line+2," * ")
  call append(s:line+3," * Input: ")
  call append(s:line+4," * ")
  call append(s:line+5," * Output: ")
  call append(s:line+6," * ")
  call append(s:line+7," * Description: ")
  call append(s:line+8," * ")
  call append(s:line+9," * Author - Siddharth Shah")
  call append(s:line+10," * Date - ".strftime("%b %d %Y"))
  call append(s:line+11," */")
  unlet s:line
endfunction

nmap 3 <Esc>mz:execute FunctionHeadingPersonal()<CR>`zjA

"Automatically adding comments section
function FunctionHeading2()
  let s:line=line(".")
  call setline(s:line,"/**")
  exe 'normal! ' . "o"
  call append(s:line+1," * @name name_function ")
  call append(s:line+2," * @brief description")
  call append(s:line+3," * ")
  call append(s:line+4," * Detail description")
  call append(s:line+5," * ")
  call append(s:line+6," * @param [in] name_input Description of input")
  call append(s:line+7," * ")
  call append(s:line+8," * @retval name_retvalue Description of ouptut")
  call append(s:line+9," * ")
  call append(s:line+10," * Example Usage: ")
  call append(s:line+11," * @code ")
  call append(s:line+12," *   name_function();//Description ")
  call append(s:line+13," * @endcode ")
  call append(s:line+14," */")
  unlet s:line
endfunction

nmap 4 <Esc>mz:execute FunctionHeading2()<CR>`zjA

"Automatically adding comments section
function AddTodo()
  let s:line=line(".")
  call append(s:line,"// @todo { paradraph describing what is to be done }")
  exe 'normal! ' . "o"
  unlet s:line
endfunction

nmap 5 <Esc>mz:execute AddTodo()<CR>`zjA

"Automatically adding comments section
function AddGroupDef()
  let s:line=line(".")
  call setline(s:line,"/** ")
  exe 'normal! ' . "o"
  call append(s:line+1,"* @defgroup name_of_group Name Group") 
  call append(s:line+2,"*/ ")
  unlet s:line
endfunction

nmap 6 <Esc>mz:execute AddGroupDef()<CR>`zjA

"Automatically adding comments section
function Add2Group()
  let s:line=line(".")
  call setline(s:line,"/** @addtogroup name_of_group */")
  exe 'normal! ' . "o"
  unlet s:line
endfunction

nmap 7 <Esc>mz:execute Add2Group()<CR>`zjA

"Automatically adding comments section
function AddStartGroup()
  let s:line=line(".")
  call setline(s:line,"/*@{*/")
  exe 'normal! ' . "o"
  unlet s:line
endfunction

nmap 9 <Esc>mz:execute AddStartGroup()<CR>`zjA

"Automatically adding comments section
function AddEndGroup()
  let s:line=line(".")
  call setline(s:line,"/*@}*/")
  exe 'normal! ' . "o"
  unlet s:line
endfunction

nmap 0 <Esc>mz:execute AddEndGroup()<CR>`zjA



map <F2> :execute "vimgrep /" . expand("<cword>") . "/j *.c" <Bar> cw<CR>

map <F3> :execute "vimgrep /" . expand("<cword>") . "/j *.h" <Bar> cw<CR>

"Commited to git
