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
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = {
            ...,
        },
        {
            "LazyVim/LazyVim",
            opts = {
                colorscheme = "gruvbox",
            },
        },
    },
}
