-- Add this to your LazyVim config in lua/plugins/presence.lua
-- This configuration will display "confidential project" for any directory inside bnp-projects
-- and hide actual file names with "confidential file"

return {
    -- Discord presence plugin
    {
        "andweeb/presence.nvim",
        config = function()
            -- Function to check if the current workspace is in bnp-projects
            local function is_confidential(path)
                if not path then
                    return false
                end
                return string.match(path, ".*/bnp%-projects/.*") or path:find("bnp%-projects$")
            end

            require("presence").setup({
                auto_update = true,
                neovim_image_text = "The One True Text Editor",
                main_image = "neovim",
                log_level = nil,
                debounce_timeout = 10,
                enable_line_number = false,
                blacklist = {},
                buttons = true,
                file_assets = {},
                show_time = true,

                -- Hide all project names in bnp-projects
                workspace_text = function(project_name, workspace)
                    if is_confidential(workspace) then
                        return "confidential project"
                    end

                    -- Default behavior for other directories
                    if project_name == "" then
                        return "No Project"
                    else
                        return project_name
                    end
                end,

                -- Hide all file names in bnp-projects
                editing_text = function(filename, editing_file)
                    if is_confidential(editing_file) then
                        return "Editing confidential file"
                    else
                        return "Editing " .. filename
                    end
                end,

                file_explorer_text = function(filename, file_explorer)
                    if is_confidential(file_explorer) then
                        return "Browsing confidential files"
                    else
                        return "Browsing " .. filename
                    end
                end,

                reading_text = function(filename, reading_file)
                    if is_confidential(reading_file) then
                        return "Reading confidential file"
                    else
                        return "Reading " .. filename
                    end
                end,

                git_commit_text = "Committing changes",
                plugin_manager_text = "Managing plugins",
                line_number_text = "Line %s out of %s",
            })
        end,
    },
}
