
"---------------------------
" Start Neobundle Settings.
"---------------------------

"行番号の表示
set number
set cursorline
" 改行時に前の行のインデントを継続する
set autoindent
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" 今後このあたりに追加のプラグインをどんどん書いて行きます！！"

NeoBundle 'vim-scripts/javacomplete'

NeoBundle 'scrooloose/nerdtree'

" シングルクオートとダブルクオートの入れ替え等
 NeoBundle 'tpope/vim-surround'

NeoBundleLazy 'vim-scripts/javacomplete', {
			\   'build': {
			\       'cygwin': 'javac autoload/Reflection.java',
			\       'mac': 'javac autoload/Reflection.java',
			\       'unix': 'javac autoload/Reflection.java',
			\   },
			\}

call neobundle#end()

"コメントのON/OFFを手軽に実行
NeoBundle 'tomtom/tcomment_vim'

" Required:
filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-------------------------

set nocompatible               " be iMproved
 filetype off                   " required!

 set rtp+=~/.vim/bundle/vundle/
 call vundle#rc()

 " let Vundle manage Vundle
 " required! 
 Bundle 'gmarik/vundle'

 " My Bundles here:
 "
 " original repos on github
 Bundle 'tpope/vim-fugitive'
 Bundle 'Lokaltog/vim-easymotion'
 Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
 Bundle 'tpope/vim-rails.git'
 " vim-scripts repos
 Bundle 'L9'
 Bundle 'FuzzyFinder'
 " non github repos
 Bundle 'git://git.wincent.com/command-t.git'
 " git repos on your local machine (ie. when working on your own plugin)
 Bundle 'file:///Users/gmarik/path/to/plugin'
 " ...

 filetype plugin indent on     " required!
 "
 " Brief help
 " :BundleList          - list configured bundles
 " :BundleInstall(!)    - install(update) bundles
 " :BundleSearch(!) foo - search(or refresh cache first) for foo
 " :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Bundle command are not allowed..

 Bundle 'altercation/vim-colors-solarized'

 syntax enable
 set background=dark
 colorscheme solarized

 " タブを表示するときの幅
 set tabstop=4
 " " タブを挿入するときの幅
  set shiftwidth=4
 " " タブをタブとして扱う(スペースに展開しない)
  set noexpandtab
 " " 
  set softtabstop=0

	"[JAVA] :Makeでコンパイル
	autocmd FileType java :command! Makejava call s:Makejava()
	function! s:Makejava()
	    :w
	    let path = expand("%")
	    let syn = "javac ".path
	    let dpath = split(path,".java$")
	    let ret = system(syn)
	    if ret == ""
	        :echo "=======\r\nCompile Success"
	    else
	        :echo "=======\r\nCompile Failure\r\n".ret 
	    endif
	endfunction
	
	"[JAVA] :Doでコンパイル後のファイルを実行 
	autocmd FileType java :command! Dojava call s:Dojava()
	function! s:Dojava()
	    let path = expand("%")
	    let dpath = split(path,".java$")
	    let syn = "java ".dpath[0]
	    let ret = system(syn)
	    :echo "=======\r\n実行結果:\r\n".ret
	endfunction
	
	"[JAVA] :Exeでコンパイルしてから実行
	autocmd FileType java :command! Exejava call s:Javac()
	function! s:Javac()
	    :w
	    let path = expand("%")
	    let syn = "javac ".path
	    let dpath = split(path,".java$")
	    let ret = system(syn)
	    if ret == ""
	        :echo "=======\r\nCompile Success"
	        let syn = "java ".dpath[0]
	        let ret = system(syn)
	        :echo "=======\r\n実行結果:\r\n".ret
	    else
	        :echo "=======\r\nCompile Failure\r\n".ret
	    endif
	endfunction


autocmd FileType java :setlocal omnifunc=javacomplete#Complete
autocmd FileType java :setlocal completefunc=javacomplete#CompleteParamsInfo
