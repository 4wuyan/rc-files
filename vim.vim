" Add 'source %file%' in the main .vimrc file

"----------------------------------------------------------------------
" General
"----------------------------------------------------------------------

set nocompatible " Avoid using obsolete vi commands
" set number " Show line numbers on the left
if has("mouse")
    set mouse=a " Scroll, and select without line number in xterm
endif
set backspace=indent,eol,start " Make BACKSPACE act normally as it's expected
set encoding=utf8
set ruler

autocmd BufWritePre * %s/\s\+$//e "automatically trim trailing white space on save

" Keep indentation when wrapping long lines
if has("patch-7.4.354")
    set breakindent
endif

" Jump to the last position when reopening a file (:help last-position-jump)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


"----------------------------------------------------------------------
" Text, tab and indent related
"----------------------------------------------------------------------

" Tab settings based on Python, see https://wiki.python.org/moin/Vim
set expandtab " Convert tabs to spaces;
set tabstop=8 " How many columns a tab counts for;
set shiftwidth=4 " How many columns text is indented with the reindent operations (<< and >>);
set softtabstop=4 " How many columns vim uses when you hit Tab in insert mode.

" Enable filetype plugins
if has("autocmd")
    filetype plugin indent on
endif

"set foldmethod=indent " Fold codes according to indent when a file is opened

set autoindent " for those filetypes whose plugins don't indent smartly
    " I add this due to Haskell. See http://vim.wikia.com/wiki/Indenting_source_code

"----------------------------------------------------------------------
" Compile & Run
"----------------------------------------------------------------------

" See http://blog.chinaunix.net/uid-21202106-id-2406761.html
func! CompileCode()
    exec "w"
    if &filetype == "cpp"
        exec "!g++ % -o %<"
    elseif &filetype == "c"
        exec "!gcc % -o %<"
    elseif &filetype == "python"
        exec "!python %"
    elseif &filetype == "java"
        exec "!javac %"
    elseif &filetype == "haskell"
        exec "!ghci %"
    endif
endfunc

func! RunResult()
    exec "w"
    if &filetype == "cpp"
        exec "! ./%<"
    elseif &filetype == "c"
        exec "! ./%<"
    elseif &filetype == "python"
        exec "!python %"
    elseif &filetype == "java"
        exec "!java %:t:r"
    endif
endfunc

map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>
vmap <F5> <ESC>:call CompileCode()<CR>

map <F6> :call RunResult()<CR>

"----------------------------------------------------------------------
" GUI Settings
"----------------------------------------------------------------------

" See https://github.com/spf13/spf13-vim

" GVIM- (here instead of .gvimrc)
if has('gui_running')
    colorscheme desert

    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
        return  (has('win32') || has('win64'))
    endfunction

    " http://vim.wikia.com/wiki/Hide_toolbar_or_menus_to_see_more_text
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    "set lines=40                " 40 lines of text instead of 24
    if LINUX()
        set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
    elseif OSX()
        set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
    elseif WINDOWS()
        set guifont=Andale_Mono:h14,Menlo:h14,Consolas:h13,Courier_New:h14
        set guifontwide=nsimsun
    endif
endif

"----------------------------------------------------------------------
" Colors
"----------------------------------------------------------------------
set background=dark
" Enable syntax highlighting
if has("syntax")
    syntax on
endif

" Hightlight trailing white spaces
    " These settings might be overwritten by colorscheme command, so they are
    " put after colorscheme settings.
    " See http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    " highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
    " match ExtraWhitespace /\s\+$/

" Change the colour of line numbers
    " Make the line number colour less obtrusive.
    " Should be placed after other color settings.
    highlight LineNr ctermfg=Grey guifg=Grey
    " The full version of the setting can be:
    "highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
    highlight Comment ctermfg=Grey guifg=Grey
