vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

-- Options
opt.number = true
opt.cursorcolumn = true
opt.cursorline = true
opt.colorcolumn = '80'
opt.backspace = 'indent,eol,start'

-- -- kill the swp files
opt.backup = false
opt.swapfile = false
-- -- spacing n stuff
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.mouse = 'a'

opt.showcmd = true
opt.showmode = true
opt.hlsearch = true
opt.incsearch = true

--Set background as dark
opt.background = 'dark'

--Don't show the splash screen on startup
opt.shortmess = 'I'

--Change list chars
opt.listchars = 'tab:»·,trail:·,space:.,eol:¬'

--With long filenames make the ENTER to continue business less likely
opt.cmdheight = 3

-- Prevent screen clear on vim exit (bg too)
-- https://github.com/garybernhardt/dotfiles/blob/7e0f353bca25b07d2ef9bcae2070406e3d4ac029/.vimrc#L57
-- http://www.shallowsky.com/linux/noaltscreen.html
-- This is now handled on a system level by a line in .Xresources
vim.cmd [[
  set t_ti= t_te=
]]

-- avoid stripe shell slowdown
opt.shell='/bin/bash --norc -i'

--[[
*****************
  MAPPINGS
*****************
--]]

-- function assigned to var
local map = vim.keymap.set

--------------
-- INSERT MODE
--------------

-- jk to escape using ctrl-c
map('i', 'jk', '<C-c>')

--------------
-- NORMAL MODE
--------------

map('n', '<leader>q', ':bd<CR>')
map('n', '<leader>wq', ':w|bd<CR>')

map('n', '<leader>ev', ':e $MYVIMRC<CR>')
map('n', '<leader>eb', ':e ~/.bashrc<CR>')
map('n', '<leader>sv', ':source $MYVIMRC<CR>')

-- Thanks Travitz
-- I can't relearn this: https://github.com/neovim/neovim/pull/13268
map('n', 'Y', 'yy')

-- buffer list next/prev
-- map('n', 'ƒ', ':bn<CR>')
-- map('n', '∂', ':bp<CR>')
map('n', '<esc>f', ':bn<CR>')
map('n', '<esc>d', ':bp<CR>')

-- vimsplit navigation for vim-tmux-navigator plugin
-- who splits??? AMIRIGHT???
map('n', '<c-j>', '<c-w><c-j>')
map('n', '<c-k>', '<c-w><c-k>')
map('n', '<c-l>', '<c-w><c-l>')
map('n', '<c-h>', '<c-w><c-h>')

-- ditch search highlight
map('n', '<F3>', ':nohlsearch<CR>')

map('n', '<leader>l', ':set list!<CR>')

-- get filename (this can likely be replaced with something nicer in nvim)
map('n', '<leader>f', ':let @+=expand("%")<CR>')

---------------
-- COMMAND MODE
---------------

-- set emacs style command line shortcuts
map('c', '<c-a>', '<Home>')
map('c', '<c-f>', '<Right>')
map('c', '<c-b>', '<Left>')
map('c', '<c-e>', '<End>')

--------------
-- VISUAL MODE
--------------

-- global yank
map('v', 'gy', '"+y')

-- sort
map('v', '<leader>s', ':sort<CR>')

-- write from vim to other tmux panes
-- originally I wanted to end up at the bottom of a 'paragraph'...
-- If you want that add '}' after the <CR> i.e. '<CR>}'
map('v', '<leader>0', ':Twrite 0<CR>')
map('v', '<leader>1', ':Twrite 1<CR>')
map('v', '<leader>2', ':Twrite 2<CR>')
map('v', '<leader>3', ':Twrite 3<CR>')
map('v', '<leader>4', ':Twrite 4<CR>')
map('v', '<leader>5', ':Twrite 5<CR>')
map('v', '<leader>6', ':Twrite 6<CR>')


--[[
*****************
  PLUGINS
*****************
--]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    'mhartington/oceanic-next',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme OceanicNext]])
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  'christoomey/vim-tmux-navigator',
  'junegunn/vim-easy-align',
  'nvim-tree/nvim-tree.lua',
  -- 'tpope/vim-tbone',
  { dir = "~/git/vim-tbone" },
  'junegunn/vim-easy-align',
  'nvim-lualine/lualine.nvim',
  'neovim/nvim-lspconfig',
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      })
    end,
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
})

local actions = require('telescope.actions')
require('telescope').setup({
  defaults = {
    layout_strategy = 'horizontal',
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    },
  }
})
pcall(require('telescope').load_extension, 'fzf')

--[[
*****************
  TELESCOPE MAPPINGS
*****************
--]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- fuzzy finding with fzf
map('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles'})
map('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep'})
map('n', '<leader><leader>', builtin.buffers, { desc = '[F]ind [B]uffers'})
-- map('n', '<leader>fc', require('plugins.telescope').find_dotfiles, { desc = '[F]ind [C]onfig'})
map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
map('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
map('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

--[[
*****************
  LSP
*****************
--]]

local function on_attach(client, bufnr)
  local function nmap(key, action)
    local opts = { noremap=true, silent=true, buffer = bufnr }
    vim.keymap.set('n', key, action, opts)
  end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('gd', vim.lsp.buf.definition)
  nmap('gt', vim.lsp.buf.type_definition)
  nmap('gi', vim.lsp.buf.implementation)
  nmap('gr', vim.lsp.buf.references)
  nmap('K', vim.lsp.buf.hover)
  --nmap('<C-k>', vim.lsp.buf.signature_help)
  nmap('<space>rn', vim.lsp.buf.rename)
  nmap('<space>ca', vim.lsp.buf.code_action)
  nmap('<space>f', vim.lsp.buf.formatting)

  -- diagnostic
  nmap('<space>e', vim.diagnostic.open_float)
  nmap('<space>dj', vim.diagnostic.goto_next)
  nmap('<space>dk', vim.diagnostic.goto_prev)
end

-- require'lspconfig'.solargraph.setup{
--   on_attach = on_attach
-- }

--[[
*****************
  LUALINE
*****************
--]]
-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'OceanicNext',
    component_separators = '|',
    section_separators = '',
  },
  tabline = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {'tabs'}
  },
}

--[[
*****************
  TREESITTER
*****************
--]]
-- ripped from Travitz

require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = 'all',
  -- https://github.com/claytonrcarter/tree-sitter-phpdoc/issues/15
  ignore_install = { 'phpdoc' },
  highlight = { enable = true },
  indent = {
    enable = true,
    disable = { 'go', 'python' }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      -- conflict with tmux?
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

function test()
  vim.cmd("echom",
    vim.fn.system({ "ls" })
  )
end
