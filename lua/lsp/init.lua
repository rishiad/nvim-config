local capabilities = require('lsp.handlers').capabilities

-- Rust
local rust = require("rust-tools")
local opts = {
    server = {
        -- standalone = true,
        capabilities = capabilities
        -- on_attach = function(_, bufnr)
        -- vim.keymap.set("n", "<Leader>k", rust.hover_actions.hover_actions, { buffer = bufnr })
        -- vim.keymap.set("n", "<Leader>a", rust.code_action_group.code_action_group, { buffer = bufnr })
        -- end,
    },
    tools = {
        hover_actions = {
            auto_focus = true
        }
    }
}
rust.setup(opts)

local lsp_config =  require("lspconfig")

    -- Python
    lsp_config.pyright.setup {}

    -- LUA
    lsp_config.lua_ls.setup {
        autostart = false,
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        }
    }

    -- Bash
    lsp_config.bashls.setup {
        autostart = false
    }

    -- Javascript/Typescript
    lsp_config.eslint.setup({
        autostart = false,
        capabilities = capabilities,
        settings = {
            packageManager = 'npm'
        },
        on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                command = "EslintFixAll",
            })
        end,
    })

    -- HTML
    lsp_config.html.setup {
        autostart = false,
        capabilities = capabilities,
    }

    -- CSS
    lsp_config.cssls.setup {
        autostart = false,
        capabilities = capabilities
    }

    -- Dockerfile
    lsp_config.dockerls.setup {
        autostart = false,
        capabilities = capabilities
    }

    -- Docker compose
    lsp_config.docker_compose_language_service.setup {
        autostart = false,
        capabilities = capabilities
    }
    -- XML
    lsp_config.lemminx.setup{}
