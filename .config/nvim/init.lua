vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.cmd('let &packpath = &runtimepath')

vim.cmd('source ~/.vimrc')

---------------- Tree Sitter ----------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

---------------- Helpers ----------------
local function merge(...)
  local result = {}
  -- For each source table
  for _, t in ipairs{...} do
    -- For each pair in t
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end



---------------- Setup Status Line ---------------
local lsp_status = require('lsp-status')
lsp_status.register_progress()

vim.cmd([[
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction
]])

---------------- Setup LSP ---------------
local nvim_lsp = require'lspconfig'
local default_options = {
    on_attach = lsp_status.on_attach,
    capabilities = lsp_status.capabilities,
}

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

require('rust-tools').setup(merge(default_options, opts))

---------------- Typescript LSP Setup ---------------
nvim_lsp.tsserver.setup(default_options)

---------------- Ruby LSP Setup ---------------
local solargraph_opts = {
  settings = {
    solargraph = {
      use_bundler = true,
    },
  },
}

nvim_lsp.solargraph.setup(merge(default_options, solargraph_opts))
nvim_lsp.sorbet.setup(default_options)
nvim_lsp.ruby_lsp.setup(default_options)

---------------- JSON LSP Setup ---------------
local json_capabilities = vim.lsp.protocol.make_client_capabilities()
json_capabilities.textDocument.completion.completionItem.snippetSupport = true

json_capabilities = merge(lsp_status.capabilities, json_capabilities)

local json_opts = {
  capabilities = json_capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  },
}

nvim_lsp.jsonls.setup(merge(default_options, json_opts))

---------------- Bash LSP Setup ---------------
require'lspconfig'.bashls.setup{}

---------------- TailwindCss LSP Setup ---------------
require'lspconfig'.tailwindcss.setup{}

---------------- ESLint LSP Setup ---------------
local function eslint_on_attach(client, bufnr)
  vim.cmd('autocmd BufWritePre <buffer> :EslintFixAll')

  lsp_status.on_attach(client, bufnr)
end

local eslint_opts = {
  settings = {
    packageManager = "yarn",
  },
  on_attach = eslint_on_attach,
}

require'lspconfig'.eslint.setup(merge(default_options, eslint_opts))

---------------- Go LSP Setup ---------------
nvim_lsp.gopls.setup{}

---------------- Vale Setup ---------------
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.vale,
    },
})


---------------- LSP Trouble --------------------
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
  {silent = true, noremap = true}
)

---------------- LSP Keybindings ----------------
-- Code navigation shortcuts
-- as found in :help lsp
vim.cmd('nnoremap <silent> <c-[> <cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.cmd('nnoremap <silent> <c-]> <cmd>lua vim.diagnostic.goto_next()<CR>')
vim.cmd('nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>')
vim.cmd('nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>')
vim.cmd('nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>')
vim.cmd('nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.cmd('nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>')
vim.cmd('nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>')
vim.cmd('nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
vim.cmd('nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>')

vim.cmd('nnoremap <silent> <leader>r      <cmd>lua vim.lsp.buf.rename()<CR>')
vim.cmd('nnoremap <silent> <leader>ca     <cmd>lua vim.lsp.buf.code_action()<CR>')
vim.cmd('nnoremap <silent> <leader><leader>     <cmd>lua vim.lsp.buf.code_action()<CR>')
vim.cmd('nnoremap <silent> <leader>f      <cmd>lua vim.lsp.buf.formatting()<CR>')
vim.cmd('nnoremap <silent> <leader>ff     <cmd>EslintFixAll<CR>')

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
    -- Add tab support -- WARNING this breaks copilot so lets leave it off right now
    -- What I think I need to do is only have these mapping apply when completion is active
    -- But not sure how to do that
    -- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    -- ['<Tab>'] = cmp.mapping.select_next_item(),
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


-- Auto Save Config
local autosave = require("auto-save")

autosave.setup(
    {
        enabled = true,
        trigger_events = {"InsertLeave", "TextChanged"},
        debounce_delay = 135
    }
)

-- Telescope --
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
require('telescope').load_extension('fzf')
require("telescope").load_extension('emoji')


-- NvimTree - File navigator sidebar
local remap = vim.api.nvim_set_keymap
function nnoremap(from, to)
  remap('n', from, to, {noremap = true})
end
require('nvim-tree').setup()
nnoremap('<C-n>', ':NvimTreeToggle<CR>')
nnoremap('<C-m>', ':NvimTreeFindFile<CR>')
nnoremap('<leader>m', ':NvimTreeFindFile<CR>')
-- nnoremap('<leader>r', ':NvimTreeRefresh<CR>')
