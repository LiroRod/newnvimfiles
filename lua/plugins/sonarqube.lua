local analyzers_path = vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension/analyzers/"

local sonarlint_ft = {
    "c",
    "cpp",
    "css",
    "docker",
    "go",
    "html",
    "java",
    "javascript",
    "javascriptreact",
    "php",
    "python",
    "typescript",
    "typescriptreact",
    "xml",
    "yaml.docker-compose",
}

---@type LazySpec
return {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = sonarlint_ft,
    specs = {
        {
            optional = true,
            opts = function(_, opts)
                opts.ensure_installed =
                    require("astrocore").list_insert_unique(opts.ensure_installed, { "sonarlint-language-server" })
            end,
        },
        {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            optional = true,
            opts = function(_, opts)
                local astrocore = require("astrocore")
                opts.ensure_installed =
                    astrocore.list_insert_unique(opts.ensure_installed, { "sonarlint-language-server" })
            end,
        },
    },
    opts = {
        server = {
            cmd = {
                "sonarlint-language-server",
                "-stdio",
                "-analyzers",
                analyzers_path .. "sonargo.jar",
                analyzers_path .. "sonarhtml.jar",
                analyzers_path .. "sonariac.jar",
                analyzers_path .. "sonarjava.jar",
                analyzers_path .. "sonarjavasymbolicexecution.jar",
                analyzers_path .. "sonarjs.jar",
                analyzers_path .. "sonarphp.jar",
                analyzers_path .. "sonarpython.jar",
                analyzers_path .. "sonarxml.jar",
            },
            -- Configure diagnostics to trigger only on save
            handlers = {
                ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    update_in_insert = false,
                }),
            },
            on_attach = function(client, bufnr)
                -- Disable automatic diagnostics
                vim.diagnostic.disable(bufnr)

                -- Enable diagnostics only on save
                vim.api.nvim_create_autocmd("BufWritePost", {
                    buffer = bufnr,
                    callback = function()
                        vim.diagnostic.enable(bufnr)
                        vim.lsp.buf_request(bufnr, "textDocument/diagnostic", {
                            textDocument = vim.lsp.util.make_text_document_params(bufnr),
                        })
                    end,
                })
            end,
        },
        filetypes = sonarlint_ft,
    },
}
