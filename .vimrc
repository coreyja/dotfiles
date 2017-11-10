" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'kopischke/vim-fetch'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'scrooloose/nerdtree'

Plug 'editorconfig/editorconfig-vim'

Plug 'keith/investigate.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let g:investigate_use_dash=1


" :Rg (Source: https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2)
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* Rgrex call fzf#vim#grep('rg --column --line-number --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

set grepprg=rg\ --vimgrep

set backspace=indent,eol,start

" NerdTree Toggle
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" Open fzf Files
map <C-f> :Files<CR>
map <C-d> :GFiles?<CR>
map <C-b> :Buffers<CR>

" Enable Mouse Mode (in Tmux)
set ttymouse=xterm2
set mouse=a

" Set EditorConfig to play nicely with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_core_mode = 'external_command'

" Set Line Numers On (No Relative cause it was laggy and did not help me much)
set number

" Strip trailing whitespace EXCEPT for markdown files
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown let b:noStripWhitespace=1

" Train myself to use the VIM navigation :sadnerd:
" inoremap  <Up>     <NOP>
" inoremap  <Down>   <NOP>
" inoremap  <Left>   <NOP>
" inoremap  <Right>  <NOP>
" noremap   <Up>     <NOP>
" noremap   <Down>   <NOP>
" noremap   <Left>   <NOP>
" noremap   <Right>  <NOP>

" Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=1 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" CloseTag Settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.html.erb'

" Use old RegEx parser that has better Ruby performance
set regexpengine=1
