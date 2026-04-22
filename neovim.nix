{pkgs, ...}: 
let
  pluginPackages = with pkgs.vimPlugins; [
      oil-nvim
      vim-fugitive
      gitsigns-nvim
      fzf-lua
      nvim-unception
      nvim-surround
      nvim-dap
      which-key-nvim
      sonarlint-nvim
      rustaceanvim
  ];

  plugins = map (package: { plugin = package; }) pluginPackages;

  dependencies = with pkgs; [
    ltex-ls
    sonarlint-ls
    lua-language-server
    nixd
    ty
    ruff
    zls
    rust-analyzer
  ];

  nvimrt = pkgs.stdenv.mkDerivation {
    name = "nvimrt";
    src = ./nvimrt;
    buildPhase = ''
      mkdir $out
      rm init.lua
    '';
    installPhase = ''
      cp -r -- * $out
    '';
  };
in
pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
  inherit plugins;
  luaRcContent = builtins.readFile ./nvimrt/init.lua + ''vim.opt.rtp:prepend('${nvimrt}')'';
  wrapperArgs = ''
    --prefix PATH : ${pkgs.lib.makeBinPath dependencies} \
  '';
  wrapRc = true;
  viAlias = false;
  vimAlias = false;
  withRuby = false;
  withNodeJs = false;
  withPython3 = true;

}
