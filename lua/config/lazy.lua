local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


-- Vim options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.relativenumber = true
vim.o.background = 'dark'
vim.opt.autowrite = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = true



require("lazy").setup("plugins")
