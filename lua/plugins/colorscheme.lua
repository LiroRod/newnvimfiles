return {
    -- {
    --     "nyoom-engineering/oxocarbon.nvim",
    --     priority = 1000,
    -- },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "oxocarbon",
    --     },
    -- },
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("oxocarbon")
    end,
  },
}
