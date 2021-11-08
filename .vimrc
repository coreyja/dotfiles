" Install vim-plugged in needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugged')

" Declare the list of plugins.
Plug 'alvan/vim-closetag'
Plug 'kopischke/vim-fetch'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'dbeniamine/todo.txt-vim'

Plug 'kana/vim-textobj-user'
Plug 'tek/vim-textobj-ruby'

" Rust Support
Plug 'rust-lang/rust.vim'
Plug 'pest-parser/pest.vim'
" Rust

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
" Plug 'fannheyward/coc-marketplace', {'do': 'yarn install --frozen-lockfile'}
" Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-jest', {'do': 'yarn install --frozen-lockfile'}
" Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
" Plug 'iamcco/coc-tailwindcss',  {'do': 'yarn install --frozen-lockfile && yarn run build'}
" Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}

Plug 'janko/vim-test'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'coreyja/fzf.devicon.vim'
" Plug '~/Projects/fzf.devicon.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'

Plug 'editorconfig/editorconfig-vim'

Plug 'keith/investigate.vim'

" Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'itchyny/lightline.vim'

Plug 'skielbasa/vim-material-monokai'
Plug 'flrnprz/plastic.vim'
" Plug 'coreyja/vim-material-monokai', { 'dir': '~/Projects/vim-material-monokai' }

Plug 'junegunn/rainbow_parentheses.vim'
Plug 'thiagoalessio/rainbow_levels.vim'

Plug 'w0rp/ale'

Plug 'itspriddle/vim-marked'

Plug 'unblevable/quick-scope'

Plug 'meain/vim-package-info', { 'do': 'npm install' }

Plug 'stefandtw/quickfix-reflector.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'gisphm/vim-gitignore'

" LSP Config
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/lsp-status.nvim'

" Autocompletion framework
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/popup.nvim'

Plug 'segeljakt/vim-silicon'
let g:silicon = {
      \ 'default-file-pattern': '~/images/silicon-{time:%Y-%m-%d-%H%M%S}.png',
      \ 'theme': '/Users/coreyja/themer-theme/output/sublime-text/themer-sublime-text-dark.tmTheme',
      \ }

" Plug 'APZelos/blamer.nvim'
" let g:blamer_enabled = 1
" let g:blamer_delay = 250
" let g:blamer_prefix = '    '
" let g:blamer_show_in_visual_modes = 0
" let g:blamer_relative_time = 1

Plug 'mcchrish/nnn.vim'

Plug 'kamykn/spelunker.vim' " Spellcheck in code
Plug 'kamykn/popup-menu.nvim' " Even though we also have the lua popup plugin we still need this one for the spelunker plugin to work right

" Github CoPilot
Plug 'github/copilot.vim'

Plug 'ryanoasis/vim-devicons' " This needs to go last to it can alter other plugins

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let mapleader = ' '

let g:investigate_use_dash=1
nnoremap <leader>i :call investigate#Investigate('n')<CR>
vnoremap <leader>i :call investigate#Investigate('v')<CR>

" Theme
set termguicolors
colorscheme ThemerVim

" Airline Config
" if !has('nvim')
"     source ~/.config/nvim/autoload/airline/themes/coreyja.vim
" end
" let g:airline_powerline_fonts = 1
" set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" let g:airline#extensions#tabline#enabled = 1
" let g:airline_theme='materialmonokai'

" Lightline Config
let g:lightline = {
  \ 'component_function': {
  \   'lspstatus': 'LspStatus',
  \ },
  \   'colorscheme': 'ThemerVimLightline',
  \   'active': {
  \     'right': [
  \                [ 'lineinfo' ],
  \                [ 'percent' ],
  \                [ 'fileformat', 'fileencoding', 'filetype' ],
  \                [ 'lspstatus' ],
  \              ],
  \   },
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' },
  \ }


let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : ['%F', '%I:%M %p'],
      \'y'    : '#H',
      \'z'    : '#(rainbarf --battery --remaining --tmux --bright)',
      \'options': {
      \  'status-justify': 'left'}
      \}

" :Rg (Source: https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2)
command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
command! -bang -nargs=* Rgrex call fzf#vim#grep('rg --column --line-number --no-heading --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

set backspace=indent,eol,start

" NerdTree Toggle
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" " Open fzf Files
map <C-f> :FilesWithDevicons<CR>
map <C-d> :GFilesWithDevicons?<CR>
map <C-g> :GFilesWithDevicons<CR>
map <C-b> :Buffers<CR>

" Enable Mouse Mode (in Tmux)
if !has('nvim')
    set ttymouse=xterm2
endif
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

" CloseTag Settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.html.erb'

" Use old RegEx parser that has better Ruby performance
set regexpengine=1

" Unset search Really <C-/> but vim recognizes this :shrug:
map <C-_> :let @/ = ""<CR>

function! CurrentWord()
  if exists("b:current_syntax") && b:current_syntax == 'ruby'
    normal "wyan
    return getreg('w')
  else
    return expand('<cword>')
  endif
endfunction
nnoremap <C-p> :call fzf#vim#tags(CurrentWord(), {'options': '--exact --select-1'})<CR>

" Next and Previous Buffer with tabs
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Toggle Rainbow Levels
map <F5> :RainbowLevelsToggle<cr>

fun! SafeCD(dir)
  execute 'cd' fnameescape(a:dir)
endfun
fun! RunFromDir(dir, function)
  let current_dir = getcwd()
  if !(a:dir ==? '')
    call SafeCD(a:dir)
    call a:function()
    call SafeCD(current_dir)
  else
    call a:function()
  endif
endfun
fun! RunFromGemfileDir(function)
  let gemfile_dir = fnamemodify(findfile("Gemfile"), ':p:h')
  call RunFromDir(gemfile_dir, a:function)
endfun

" RSpec.vim mappings
map <Leader>t :call RunFromGemfileDir(function('RunCurrentSpecFile'))<CR>
map <Leader>s :call RunFromGemfileDir(function('RunNearestSpec'))<CR>
map <Leader>l :call RunFromGemfileDir(function('RunLastSpec'))<CR>
map <Leader>a :call RunFromGemfileDir(function('RunAllSpecs'))<CR>

autocmd! BufRead,BufNewFile,BufEnter retail/spec/features/*.rb let b:rspecEnvVars="FEATURES=1"
autocmd! BufRead,BufNewFile,BufEnter retail/spec/system/*.rb let b:rspecEnvVars="SYSTEM=1"
" let g:rspec_command = "execute 'compiler rspec | let &makeprg=\"env ' . get(b:, 'rspecEnvVars', '') . ' spring\" | Make rspec {spec}'"
let g:rspec_command = "Dispatch rspec {spec}"

" Double Space to Save
map <Leader><Leader> :write<CR>

" Config ALE
let g:ale_fixers = {
\   'ruby': ['standardrb', 'rubocop', 'prettier'],
\   'typescript': ['eslint'],
\   'javascript': ['eslint'],
\}
let g:ale_linters = {
\   'eruby': [],
\}
map <Leader>c :ALEFix<CR>
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'

" Spellcheck
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
set complete+=kspell

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"))
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction
nnoremap z= :call FzfSpell()<CR>
" Spellcheck

" Fix CronTab
autocmd filetype crontab setlocal nobackup nowritebackup

" Copy/Paste
vnoremap p "_dP
vnoremap <Leader>c "zy<Esc>:call system('pbcopy', @z)<CR>

" Delete Current File
fun! DeleteCurrentFile()
  call delete(expand('%')) | bdelete!
endfun
nnoremap <Del><Del> :call DeleteCurrentFile()<CR>

" Rust
let g:rustfmt_autosave = 1

let g:python3_host_prog = '/usr/local/bin/python3'

let g:ruby_host_prog = 'RBENV_VERSION=$(cat ~/.ruby-version) ~/.rbenv/shims/ruby'
let g:nodejs_host_prog = 'NODENV_VERSION=$(cat ~/.node-version) ~/.nodenv/shims/node'


" test.vim config
let test#strategy = "dispatch"
nmap <silent> tn :TestNearest<CR>
nmap <silent> tf :TestFile<CR>
nmap <silent> ts :TestSuite<CR>
nmap <silent> tl :TestLast<CR>
nmap <silent> tg :TestVisit<CR>

" Find and Replace in all files
function! FindAndReplace( ... )
  if a:0 != 2
    echo "Need two arguments"
    return
  endif
  execute printf('args `rg --files-with-matches ''%s'' .`', a:1)
  execute printf('argdo %%substitute/%s/%s/g | update', a:1, a:2)
endfunction
command! -nargs=+ Jangle call FindAndReplace(<f-args>)

" NNN Config
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
nnoremap <leader>m :NnnPicker %:p:h<CR>
