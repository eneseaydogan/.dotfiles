return {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            },
        },
        ensure_installed = {
            -- C
            "clangd",
            "clang-format",
            "cpptools",
            "codelldb",

            -- Lua
            "lua-language-server",
            "stylua",
            "luacheck",

            -- Go
            "gopls",
            "goimports",
            "golangci-lint",

            -- Bash
            "bash-language-server",
            "shfmt",
            "shellcheck",

            -- Fish
            "fish-lsp",

            -- Others
            "commitlint",
            "kdlfmt",
            "taplo",
            "prettier",
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")

        mr.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then p:install() end
            end
        end)
    end,
}
