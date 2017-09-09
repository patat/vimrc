set nocompatible			              	"We want the latest vim settings/options.

so ~/.vim/plugins.vim

filetype on
syntax enable
set backspace=indent,eol,start				"Make backspace behave like every other editor.
let mapleader = ','					"The default leader is \, but comma is much better.
set nonumber						"Let's activate line numbers.
set noerrorbells visualbell t_vb=			"No damn bells!
set autowriteall					"Automatically write the file when switching buffers.
set complete=.,w,b,u					"Set out desired autocompletion matching. 
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

"------------Visuals--------------"
colorscheme atom-dark-256
set t_CO=256						"Use 256 colors. This is useful for Terminal Vim.
set guifont=Fira_Code:h14
set guioptions-=e					"We don't want Gui tabs.
set linespace=15                             		"Macvim-specific line-height.

set guioptions-=l					"Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

"We'll fake a custom left padding for each window.
hi LineNr guibg=bg
set foldcolumn=2
hi foldcolumn guibg=bg

"Get rid of ugly split borders
hi vertsplit guifg=bg guibg=bg


"------------Search--------------"
set hlsearch
set incsearch


"------------Split Management----"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

"------------Mappings------------"

"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr> 
"Make it easy to edit the Vundle plugins file.
nmap <Leader>ep :e ~/.vim/plugins.vim<cr>
"Quick edit UltiSnips snippets
nmap <Leader>es :UltiSnipsEdit<cr>

"Create/edit file in the current directory
nmap :ed :edit %:p:h/

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Make NERDTree easier to toggle.
nmap <C-n> :NERDTreeToggle<cr>

nmap <Leader>f :tag<space>

"Delete the current file and it's buffer
nnoremap <Leader>rm :call delete(expand('%')) \| bdelete!<CR>

"" React Specific Mappings
nmap <Leader>fc :%s/class=/className=/g<cr>

"-----------Plugins--------------"

"/
"/ CtrlP
"/
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git\vendor'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

nmap <Leader>pp :CtrlP<cr>
nmap <Leader>rr :CtrlPBufTag<cr>
nmap <Leader>ee :CtrlPMRUFiles<cr>

"/
"/ Prettier 
"/
nnoremap gp :silent %!prettier --stdin --trailing-comma all --single-quote<CR>

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw = 0


"/
"/ Greplace.vim 
"/
"We want to use Ag for the search.
set grepprg=ag


let g:grep_cmd_opts = '--line-numbers --noheading'



"/
"/ vim-php-cs-fixer.vim
"/
let g:php_cs_fixer_level = "psr2"
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>



"/
"/ pdv
"/
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>




"/
"/ UltiSnips
"/
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"



"/
"/ emmet-vim 
"/
let g:user_emmet_leader_key='<c-z>'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}


"/
"/ vim-jsx 
"/
let g:jsx_ext_required = 0 " Allow JSX in normal JS files




"---------Laravel-Specific-----------"
nmap <Leader>lm :!php artisan make:
"Call the artisan
nmap <Leader>la :!php artisan
"Run migration
nmap <Leader>ld :!php artisan migrate
"Easy access routes file
nmap <Leader><Leader>lr :e routes/web.php<cr>

"-----------Auto-commands---------"

"Automatically source the Vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END




function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>


function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>


"Sort PHP use statements
"http://stackoverflow.com/questions/11531073/how-do-you-sort-a-range-of-lines-by-length
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>


" Notes and Tips
" - Press 'zz' to instantly center the line where the cursor is located.
" - Press ',f' to type in a tag you'd like to go to
"   - :tn to go to the next tag
"   - :tp to fo to the prev tag
"   - :ts to list all the selected tags and choose
" - Press 'gt' to switch tabs
" - Press 'di(' to delete inside ()
" - Press 'vi(' to select inside ()
" - Press '/' and type a search query,
"   - then press 'n' to go to the next occurence
" - Use ':s/query/replacement' to multiple replace in selected area
" - Use ':wa' to write all changed files
" - Press 'FnF5' to update CtrlP file index
" - Press 'Ctrl6' to go back to the previous file
" - Press 'r' to replace
" - Press 'cs'"' to change surrounding ' with " (surround.vim)
" - Press 'ds'' to delete surrounding '
" - Press 'dst' in html to delete surrounding tag
" - Select something, Press 'S' and enter tag in html to wrap selected
" - Press 'J' to join next line with previous
" - Use ':sbuffer #' to open a split for the buffer with index #
" - Press 'mM' to mark some position and ''M' to return to that line or '`M'
"   to return to that exact position 
" - Mark a spot 'mm' and then Press 'd'm' to delete all from current spot up
"   to that mark
" Press 'yyp' to yank the line and paste in below
" Press '0 to go to the prev edit point
" Press '<' or '>' to indent selected lines
" Press '.' to repeat the last step
" Press 'qq' to start recording a macro and 'Escq' to stop, replay it by '@q'
