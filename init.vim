"-----------Plug-ins -----------"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'michaeljsmith/vim-indent-object'
Plug 'justinmk/vim-sneak'
Plug 'inkarkat/vim-ReplaceWithRegister'
" Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-vdebug/vdebug'
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'rhysd/vim-grammarous'

call plug#end()

"-----------Spelling checks-----------"
" setlocal spell
" set spelllang=en
" inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

"-----------Mappings-----------"
let mapleader = "\<Space>"
" nnoremap <F1> :terminal python3 %
nnoremap <S-j> 5j
nnoremap <S-k> 5k
nmap <silent> gd <Plug>(coc-definition)
nmap S <leader><leader>s
nmap <leader>l \ll
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" command! <F8> :w

"-----------Python settings-----------"
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>
" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e
" Open terminal and run python
" command! -nargs=* T split | lcd %:h | terminal ++curwin <args>
command! -nargs=* T split | lcd %:h | terminal <args>
nnoremap <F1> :T python3 %
nnoremap <F2> :T python3 -m ipdb %
" Map the return norm mode key to ESC in terminal mode
:tnoremap <Esc> <C-\><C-n>



"-----------Tab selection mappings-----------"
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
map <C-j> :tabprevious<CR>
map <C-k> :tabnext<CR>
nnoremap <leader>w :tabclose<CR>
nnoremap <leader>t :tabnew<CR>
" Open terminal 
command! -nargs=* T rightb vsplit | terminal <args> 
" Resize the windon split
nnoremap <leader>, 5<C-w>>
nnoremap <leader>. 5<C-w><

"-----------Tmux mapping re-settings-----------"
" nnoremap <silent> <leader>h :TmuxNavigateLeft<cr>
" nnoremap <silent> <leader>j :TmuxNavigateDown<cr>
" nnoremap <silent> <leader>k :TmuxNavigateUp<cr>
" nnoremap <silent> <leader>l :TmuxNavigateRight<cr>

"-----------Bacic settings-----------"
:set ma
set autoread
set relativenumber
set gfn=Monospace\ 14
" let g:airline_theme='papercolor'
let g:airline_theme='angr'
syntax on
colorscheme gruvbox
set hlsearch
set incsearch
" nnoremap <esc> :nohlsearch<CR><esc>
nnoremap j gj
:set shell=/bin/zsh
" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

"-----------Coc plugin settings-----------"
autocmd CursorHold * silent call CocActionAsync('highlight')
let g:coc_global_extensions = [
  \ 'coc-python', 
  \ 'coc-pairs', 
  \ ]

"-----------Vimtex settings-----------"
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
" set conceallevel=1
" let g:tex_conceal='abdmg'

"-----------UltiSnip settings-----------"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"-----------NerdTree settings-----------"
"map <C-n> :NERDTreeToggle<CR>
""Directly closing the nerdtree when there is no current window
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"-----------fzf settings-----------"
set rtp+=/usr/local/opt/fzf
nmap <leader><tab> <plug>(fzf-maps-n)
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-a> :Buffers<CR>


"-----------Save and load sessions-----------"
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction
" au VimEnter * nested :call LoadSession()
au VimLeave * :call MakeSession()
map ,l :call LoadSession()<CR>

