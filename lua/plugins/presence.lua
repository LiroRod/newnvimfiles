return {
    {
        "andweeb/presence.nvim",
        config = function()
            -- Robust detector for "bnp-projects" based on buffer path and cwd
            local function in_bnp_projects()
                local buf_path = vim.api.nvim_buf_get_name(0) or ""
                local cwd = (vim.loop and vim.loop.cwd()) or (vim.fn.getcwd() or "")
                local function is_confidential_path(p)
                    return p:match("[/\\]bnp%-projects([/\\].*)?$") ~= nil or p:match("[/\\]bnp%-projects[/\\]") ~= nil
                end
                return is_confidential_path(buf_path) or is_confidential_path(cwd)
            end

            require("presence").setup({
                auto_update = true,
                neovim_image_text = "The One True Text Editor",
                main_image = "neovim",
                log_level = nil,
                debounce_timeout = 10,
                enable_line_number = false,
                blacklist = {}, -- NOTE: don't blacklist bnp-projects; we want to censor, not disable
                buttons = false,
                file_assets = {},
                show_time = true,

                workspace_text = function(project_name, _filename)
                    if in_bnp_projects() then
                        return "confidential project"
                    end
                    if (project_name or "") == "" then
                        return "No Project"
                    else
                        return project_name
                    end
                end,

                -- Buffer is editable
                editing_text = function(filename)
                    if in_bnp_projects() then
                        return "Editing confidential file"
                    else
                        return "Editing " .. (filename or "")
                    end
                end,

                -- File explorer (e.g. netrw, neo-tree, nvim-tree)
                file_explorer_text = function(explorer_name)
                    if in_bnp_projects() then
                        return "Browsing confidential files"
                    else
                        return "Browsing " .. (explorer_name or "files")
                    end
                end,

                -- Readonly/unmodifiable buffers
                reading_text = function(filename)
                    if in_bnp_projects() then
                        return "Reading confidential file"
                    else
                        return "Reading " .. (filename or "")
                    end
                end,

                git_commit_text = "Committing changes",
                plugin_manager_text = "Managing plugins",
                line_number_text = "Line %s out of %s",
            })
        end,
    },
}
