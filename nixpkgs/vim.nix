pkgs:
{
  enable = true;
  viAlias = false;
  vimAlias = false;
  plugins = with pkgs.vimPlugins; [
    coc-nvim
    nerdtree
    lightline-vim
    vim-nix
    vim-surround
    nord-vim
  ];

  extraConfig = ''
    "" Theming
    set background=dark
    colorscheme nord

    " status line theme
    let g:lightline = { 'colorscheme': 'darcula', }

    "" Plugins mappings
    nnoremap <C-t> :NERDTreeToggle <CR>

    "" User mappings
    let mapleader = "\<Space>"

    " jk in insert mode behave like <esc>
    inoremap jk <esc>

    " select all text in buffer
    nmap <leader>a ggVG

    " remove highlighting after search
    nmap <leader>/ :noh <cr>

    " edit configs quickly
    nmap <leader>cv :tabnew ~/.config/nixpkgs/vim.nix <cr>
    nmap <leader>cc :tabnew /etc/nixos/configuration.nix <cr>
    nmap <leader>ch :tabnew ~/.config/nixpkgs/home.nix <cr>

    " additional tab navigation
    nmap <leader>tt :tabnew <cr>
    nmap <leader>tn :tabnext <cr>
    nmap <leader>tp :tabprev <cr>
    nmap <leader>to :tabo <cr>

    " Use ctrl-[hjkl] to select active split
    nmap <silent> <c-k> :wincmd k <CR>
    nmap <silent> <c-j> :wincmd j <CR>
    nmap <silent> <c-h> :wincmd h <CR>
    nmap <silent> <c-l> :wincmd l <CR>

    "" settings
    set mouse=a
    set relativenumber
    set smartindent
    set smarttab
    set expandtab
    set shiftwidth=2
    set tabstop=2

    " Remember last position
    if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
      endif
  '';
}
