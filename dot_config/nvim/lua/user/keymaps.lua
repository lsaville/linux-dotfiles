local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

------------
-- Normal --
------------

-- Thanks Travitz
-- I can't relearn this: https://github.com/neovim/neovim/pull/13268
keymap("n", "Y", "yy", { noremap = true })

-- fuzzy finding with fzf
keymap("n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
-- old habits die hard
keymap("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
keymap("n", "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
keymap("n", "<leader>fb", "<cmd>lua require('telescope.builtin').find_buffers()<cr>", { noremap = true })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- OG stuff

-- Navigate buffers
keymap("n", "ƒ", ":bnext<CR>", opts)
keymap("n", "∂", ":bprevious<CR>", opts)

keymap("n", "<leader>q", ":bd<CR>", opts)
keymap("n", "<leader>wq", ":w|bd<CR>", opts)

-- kill search lights
keymap("n", "<F3>", ":nohlsearch<CR>", opts)

-- editing init.lua isn't v fun when it requires everything from lua/user/
keymap("n", "<leader>ev", ":e $MYVIMRC<CR>", opts)
keymap("n", "<leader>eb", ":e ~/.bashrc<CR>", opts)
-- sourcing init.lua doesn't affect change in the same way restart does
keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", opts)

keymap("n", "<leader>n", ":NERDTreeToggle<CR>", opts)

-- surely nvim offers a different api for the same thing
keymap("n", "<leader>cp", ":let @+=expand('%')<CR>", opts)

------------
-- Insert --
------------

-- Press jk fast to enter
keymap("i", "jk", "<C-c>", opts)

------------
-- Visual --
------------

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

keymap("v", "<leader>j", ":!pandoc -f markdown -t jira<CR>", opts)
keymap("v", "gy", '"+y', opts)
keymap("v", "<leader>s", ":sort<CR>", opts)

keymap("v", "<leader>0", ":Twrite 0<CR>", opts)
keymap("v", "<leader>1", ":Twrite 1<CR>", opts)
keymap("v", "<leader>2", ":Twrite 2<CR>", opts)
keymap("v", "<leader>3", ":Twrite 3<CR>", opts)
keymap("v", "<leader>4", ":Twrite 4<CR>", opts)
keymap("v", "<leader>5", ":Twrite 5<CR>", opts)
keymap("v", "<leader>6", ":Twrite 6<CR>", opts)

------------------
-- Visual Block --
------------------

-- Move text up and down
-- The first here wrecks normal vim functionality I know and love, cutting them out
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--------------
-- Terminal --
--------------

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-------------
-- Command --
-------------

-- TODO this doesn't work in nvim
-- emacs style command line shortcuts
keymap("c", "<C-a>", "<Home>", opts)
keymap("c", "<C-f>", "<Right>", opts)
keymap("c", "<C-b>", "<Left>", opts)
keymap("c", "<C-e>", "<End>", opts)
