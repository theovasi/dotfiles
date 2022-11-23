vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)

	use 'Mofiqul/dracula.nvim'
	use 'preservim/nerdtree'
	use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
	}
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use 'neovim/nvim-lspconfig'
	use {'ms-jpq/coq_nvim', branch='coq'}
	use {'ms-jpq/coq.artifacts', branch='artifacts'}
	use {'ms-jpq/coq.thirdparty', branch='3p'}

end)
