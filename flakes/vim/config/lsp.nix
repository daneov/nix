{
  plugins.lsp = {
    enable = true;
    servers = {
      tsserver.enable = true;
      nil-ls.enable = true;
      lua-ls.enable = true;
      gopls.enable = true;
      nixd.enable = true;
    };
  };
}
