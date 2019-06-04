" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'alvan/vim-closetag'
Plug 'kopischke/vim-fetch'
Plug 'thoughtbot/vim-rspec'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'

Plug 'kana/vim-textobj-user'
Plug 'tek/vim-textobj-ruby'

" Rust Support
Plug 'rust-lang/rust.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'fszymanski/deoplete-emoji'
Plug 'wellle/tmux-complete.vim'
" Rust

Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'mcchrish/nnn.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'keith/investigate.vim'

Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'

Plug 'skielbasa/vim-material-monokai'
Plug 'flrnprz/plastic.vim'
" Plug 'coreyja/vim-material-monokai', { 'dir': '~/Projects/vim-material-monokai' }

Plug 'thiagoalessio/rainbow_levels.vim'

Plug 'w0rp/ale'

Plug 'jparise/vim-graphql'

Plug 'itspriddle/vim-marked'

" TypeScript
Plug 'leafgarland/typescript-vim'

Plug 'blindFS/vim-taskwarrior'

Plug 'unblevable/quick-scope'

Plug 'meain/vim-package-info', { 'do': 'npm install' }

Plug 'sheerun/vim-polyglot'
Plug 'google/vim-jsonnet'
" Plug 'ludovicchabant/vim-gutentags'

Plug 'ryanoasis/vim-devicons' " This needs to go last to it can alter other plugins

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

let mapleader = ' '

let g:investigate_use_dash=1
nnoremap <leader>i :call investigate#Investigate('n')<CR>
vnoremap <leader>i :call investigate#Investigate('v')<CR>

" Theme
set termguicolors
colorscheme material-monokai
let g:airline_theme='materialmonokai'

" Airline Config
if !has('nvim')
    source ~/.config/nvim/autoload/airline/themes/coreyja.vim
end
let g:airline_powerline_fonts = 1
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline#extensions#tabline#enabled = 1

let g:tmuxline_preset = {
      \'a'    : '#S',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : ['%F', '%I:%M %p'],
      \'y'    : '#H',
      \'z'    : '#(rainbarf --battery --remaining --rgb --tmux)',
      \'options': {
      \  'status-justify': 'left'}
      \}

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

" Files + devicons
function! Fzf_files_with_dev_icons(command)
  let l:fzf_files_options = '--preview "bat --color always --style numbers {2..} | head -'.&lines.'"'

  function! s:edit_devicon_prepended_file(item)
    let l:file_path = a:item[4:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': a:command.' | devicon-lookup --color',
        \ 'sink':   function('s:edit_devicon_prepended_file'),
        \ 'options': '--ansi -m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

function! Fzf_git_diff_files_with_dev_icons()
  let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\""'

  function! s:edit_devicon_prepended_file_diff(item)
    echom a:item
    let l:file_path = a:item[7:-1]
    echom l:file_path
    let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")

    execute 'silent e' l:file_path
    execute l:first_diff_line_number
  endfunction

  call fzf#run({
        \ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup --color',
        \ 'sink':   function('s:edit_devicon_prepended_file_diff'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

" Open fzf Files
map <C-f> :call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND . " --color always")<CR>
map <C-d> :call Fzf_git_diff_files_with_dev_icons()<CR>
map <C-g> :call Fzf_files_with_dev_icons("git ls-files \| uniq")<CR>
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

" TagBar
nmap <F8> :TagbarToggle<CR>
" Use Ripper Tags with Tagbar
if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds'      : ['m:modules',
                      \ 'c:classes',
                      \ 'C:constants',
                      \ 'F:singleton methods',
                      \ 'f:methods',
                      \ 'a:aliases'],
      \ 'kind2scope' : { 'c' : 'class',
                       \ 'm' : 'class' },
      \ 'scope2kind' : { 'class' : 'c' },
      \ 'ctagsbin'   : 'ripper-tags',
      \ 'ctagsargs'  : ['-f', '-']
      \ }
endif

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
let g:rspec_command = "execute 'compiler rspec | let &makeprg=\"env ' . get(b:, 'rspecEnvVars', '') . ' spring\" | Make rspec {spec}'"

" Double Space to Save
map <Leader><Leader> :write<CR>

" Config ALE
let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'typescript': ['tslint'],
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

" ## LanguageClient
" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['javascript-typescript-langserver'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ }
let g:deoplete#enable_at_startup = 1

let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

let g:ruby_host_prog = 'RBENV_VERSION=$(cat ~/.ruby-version) ~/.rbenv/shims/ruby'
let g:nodejs_host_prog = 'NODENV_VERSION=$(cat ~/.node-version) ~/.nodenv/shims/node'

" nnn Config
let g:nnn#command = 'nnn -l'
let g:nnn#layout = { 'left': '~20%' }
nnoremap <leader>m :NnnPicker '%:p:h'<CR>
