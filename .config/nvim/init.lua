vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.cmd('let &packpath = &runtimepath')

vim.cmd('source ~/.vimrc')

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
}


---------------- Setup LSP ---------------
local nvim_lsp = require'lspconfig'

---------------- Setup Rust LSP ----------------

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

---------------- Typescript LSP Setup ---------------
nvim_lsp.tsserver.setup {}

---------------- Ruby LSP Setup ---------------
nvim_lsp.solargraph.setup{}
nvim_lsp.sorbet.setup{}

---------------- LSP Keybindings ----------------
-- Code navigation shortcuts
-- as found in :help lsp
vim.cmd('nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>')
vim.cmd('nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>')
vim.cmd('nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.cmd('nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.cmd('nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.cmd('nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
vim.cmd('nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>')

vim.cmd('nnoremap <silent> <leader>r     <cmd>lua vim.lsp.buf.rename()<CR>')

----------- Setup Completion
----------- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'vsnip', priority = -10 },
  },

  -- This repeats some of the vim config but lets see if it helps
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect',
  },
})

vim.cmd('set signcolumn=yes')

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force user to select one from the menu
vim.cmd('set completeopt=menuone,noinsert,noselect')

-- Avoid showing extra messages when using completion
vim.cmd('set shortmess+=c')

-- I didn't like this so turning it off
-- -- Set updatetime for CursorHold
-- -- N ms of no cursor movement to trigger CursorHold
-- vim.cmd('set updatetime=1000')
-- -- Show diagnostic popup on cursor hover
-- vim.cmd('autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()')
