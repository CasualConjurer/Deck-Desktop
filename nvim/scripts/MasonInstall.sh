!#/bin/bash

nvim --headless -c "MasonInstall \
  lua-language-server \
  luacheck \
  luaformatter \
  html-lsp \
  htmlbeautifier \
  htmlhint \
  superhtml \
  css-lsp \
  css-variables-language-server \
  csskit \
  cssmodules-language-server \
  checkstyle \
  jsonlint \
  standardjs \
  typescript-language-server \
  fish-lsp \
  bash-language-server \
  docker-compose-language-service \
  docker-language-server \
  " -c "qall"
