let hostname = substitute(system('hostname'), '\n', '', '')

if hostname == "DESKTOP-TQVVGEB"
    let hostname = "windows_desktop"
elseif (hostname == "um3") || (hostname == "um2") || (hostname == "um1")
    let hostname = "net3"
elseif hostname == "zac-macook"
    let hostname = "macbook"
elseif hostname == "somnianode"
    let hostname = "linux_desktop"
endif

call plug#begin('~/.vim/plugged')

""""""""""""""""""""""
""\ BASIC SETTINGS \""
""""""""""""""""""""""

Plug 'tpope/vim-sensible'
map <SPACE> <leader>
set foldmethod=marker
set number
set numberwidth=3
set nowrap
set previewheight=30
set cursorline
set mouse=a
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
set hls is ic scs
set showcmd
set lazyredraw
set showmatch
set cinoptions=l1 " indent brackets properly within switch/case expression in C++
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.pyc
set hidden

au FileType qf setlocal nonumber colorcolumn=

"""""""""""""""""""""""""
""\ UNIVERSAL PLUGINS \""
"""""""""""""""""""""""""

Plug 'markonm/traces.vim' " search/replace preview
Plug 'coderifous/textobj-word-column.vim' " targets for editing columns
Plug 'wellle/targets.vim' " useful additional targets
Plug 'danilo-augusto/vim-afterglow' " color scheme
Plug 'tpope/vim-repeat' " adds repeat (.) ability for some plugins
Plug 'ntpeters/vim-better-whitespace' " for stripping trailing whitespace
Plug 'morhetz/gruvbox' " color theme
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

Plug 'ajh17/VimCompletesMe' " simple/quick tab completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

Plug 'godlygeek/tabular' " for aligning columns
vnoremap <Enter> :Tab<Space>/

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

" use ripgrep for file-finding with fzf
if hostname == "windows_desktop"
    let $FZF_DEFAULT_COMMAND = 'C:\tools\ripgrep-0.8.1-x86_64-pc-windows-msvc\rg.exe --files --hidden --follow --glob "!.git/*"'
else
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif

" use ripgrep to grep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

let g:fzf_command_prefix = 'Fzf'
" let g:fzf_layout = { 'up': '~40%' }
let g:fzf_layout = { 'window': '20split enew' }
nnoremap <leader>f :FzfFiles<CR>
nnoremap <leader>F :FzfBuffers<CR>
nnoremap <leader>t :FzfTags<CR>

" Customize fzf colors to match the color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

Plug 'mhinz/vim-grepper'
set grepprg=rg\ --vimgrep
nnoremap <leader>g :Grepper<CR>
nnoremap <leader>G :Grepper -cword -noprompt<CR>:cfdo %s/<C-R><C-W>/

Plug 'skywind3000/asyncrun.vim'
nnoremap <leader><Space> :call asyncrun#quickfix_toggle(12)<cr>
set novisualbell
set errorbells
let g:asyncrun_exit = "exe \"normal \<Esc>\""
let g:asyncrun_auto = "make"
nnoremap <leader>n :cn<cr>
nnoremap <leader>p :cp<cr>

Plug 'embear/vim-localvimrc'
let g:localvimrc_name = [".lvimrc"]
let g:localvimrc_sandbox = 0
let g:localvimrc_persistent = 1

"""""""""""""""""""""""""""""""""
""\ LANGUAGE-SPECIFIC PLUGINS \""
"""""""""""""""""""""""""""""""""

Plug 'bfrg/vim-cpp-modern', { 'for' : 'cpp' }
Plug 'justinmk/vim-syntax-extra', { 'for' : ['c', 'cpp'] }
Plug 'rhysd/vim-clang-format', { 'for' : ['c', 'cpp'] }
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "BreakBeforeBraces" : "Stroustrup",
            \ "ColumnLimit" : "90",
            \ "DerivePointerAlignment" : "false",
            \ "PointerAlignment" : "Left" }
let g:clang_format#auto_format=1

au FileType cpp setlocal cindent cino=j1,(0,ws,Ws

Plug 'ziglang/zig.vim', { 'for' : 'zig' }
let g:zig_fmt_autosave = 1
let g:zig_fmt_command = ['/home/zac/zig/zig-linux-x86_64-0.3.0+6cf38369/zig', 'fmt', '--color', 'off']

Plug 'lervag/vimtex', { 'for' : ['plaintex', 'latex'] }
let g:vimtex_quickfix_ignore_all_warnings=1


Plug 'parnmatt/vim-root', { 'for' : ['cpp', 'root'] }
au BufNewFile,BufRead *.C set filetype+=cpp.root

Plug 'rust-lang/rust.vim', { 'for' : 'rust' }

Plug 'neovimhaskell/haskell-vim', { 'for' : 'haskell' }
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1

Plug 'vim-pandoc/vim-pandoc', { 'for' : ['markdown', 'pdc'] }
Plug 'vim-pandoc/vim-pandoc-syntax', { 'for' : ['markdown', 'pdc'] }
let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0

call plug#end()

""""""""""""""""""
""\ APPEARANCE \""
""""""""""""""""""

set t_Co=256
set termguicolors
set background=dark
color gruvbox
set background=dark
set guifont=Fixedsys\ Excelsior\ 3.01\ Regular\ 12

set guioptions-=r
set guioptions-=L
set guioptions-=m
set guioptions-=T

" fix weird color of first line in quickfix window
hi QuickFixLine cterm=None ctermbg=256 guibg=#ffff00

" highlight commonly used comment keywords
augroup vimrc_todo
    au!
    au Syntax * syn match MyAnnotations /\v<(FIXME|NOTE|TODO|OPTIMIZE|WARNING)/
          \ containedin=.*Comment,vimCommentTitle
augroup END

hi def link MyAnnotations Todo
hi Todo ctermfg=White ctermbg=167 cterm=bold

""""""""""""""""""""""""""""""
""\ BACKUPS & UNDO HISTORY \""
""""""""""""""""""""""""""""""

silent !mkdir ~/.vim/backups > /dev/null 2>&1
silent !mkdir ~/.vim/backups/files > /dev/null 2>&1
set backupdir=~/.vim/backups/files
set backup

silent !mkdir ~/.vim/backups/undo_history > /dev/null 2>&1
set undodir=~/.vim/backups/undo_history
set undofile

silent !mkdir ~/.vim/backups/swap_files > /dev/null 2>&1
set directory=~/.vim/backups/swap_files

""""""""""""""""
""\ KEYBINDS \""
""""""""""""""""

" Fix accidental capitalization annoyance for common colon commands
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SetupCommandAlias('W', 'w')
call SetupCommandAlias('Wa', 'wa')
call SetupCommandAlias('WA', 'wa')
call SetupCommandAlias('Wq', 'wq')
call SetupCommandAlias('Wqa', 'wqa')
call SetupCommandAlias('WQa', 'wqa')
call SetupCommandAlias('WQA', 'wqa')
call SetupCommandAlias('Qa', 'qa')
call SetupCommandAlias('QA', 'qa')
call SetupCommandAlias('Vsplit', 'vsplit')
call SetupCommandAlias('VSplit', 'vsplit')
call SetupCommandAlias('Split', 'split')
call SetupCommandAlias('SPlit', 'split')

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <leader>V :vsplit<CR>
nnoremap <leader>S :split<CR>
nnoremap <leader>C :e ~/.config/nvim/init.vim<CR>

"""""""""""""""""""
""\ STATUS LINE \""
"""""""""""""""""""

" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
"
" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction
" "
" set statusline=
" set statusline+=%#PmenuSel#
" set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
" set statusline+=\ %f
" set statusline+=%m\
" set statusline+=%=
" set statusline+=%#CursorColumn#
" set statusline+=\ %y
" set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
" set statusline+=\[%{&fileformat}\]
" set statusline+=\ %p%%
" set statusline+=\ %l:%c
" set statusline+=\

" fix weird color of first line in quickfix window
hi QuickFixLine cterm=None ctermbg=256 guibg=None
