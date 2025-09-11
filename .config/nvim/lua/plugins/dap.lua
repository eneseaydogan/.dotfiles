return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        {
            "<leader>db",
            function() require("dap").toggle_breakpoint() end,
            mode = "n",
            desc = "Toggle breakpoint",
        },
        {
            "<leader>dc",
            function() require("dap").continue() end,
            mode = "n",
            desc = "Start/Continue debugging",
        },
        {
            "<leader>do",
            function() require("dap").step_over() end,
            mode = "n",
            desc = "Step over",
        },
        {
            "<leader>di",
            function() require("dap").step_into() end,
            mode = "n",
            desc = "Step into",
        },
        {
            "<leader>dO",
            function() require("dap").step_out() end,
            mode = "n",
            desc = "Step out",
        },
        {
            "<leader>dq",
            function() require("dap").terminate() end,
            mode = "n",
            desc = "Terminate debugging",
        },
        {
            "<leader>du",
            function() require("dapui").toggle() end,
            mode = "n",
            desc = "Toggle DAP UI",
        },
        {
            "<leader>de",
            function() require("dapui").eval() end,
            mode = "n",
            desc = "Toggle DAP UI",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        require("dap-python")

        require("dapui").setup({})
        require("nvim-dap-virtual-text").setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true, -- show stop reason when stopped for exceptions
            -- commented = true, -- prefix virtual text with comment string
            only_first_definition = false, -- only show virtual text at first definition (if there are multiple)
            all_references = true, -- show virtual text on all all references of the variable (not only definitions)
        })

        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
        dap.listeners.after.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.after.event_exited.dapui_config = function() dapui.close() end

        dap.adapters.cppdbg = {
            id = "cppdbg",
            type = "executable",
            command = "/home/enes-e-aydogan/.local/share/nvim/mason/bin/OpenDebugAD7",
        }

        dap.configurations.c = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    return vim.fn.input(
                        "Path to executable: ",
                        vim.fn.getcwd() .. "/",
                        "file"
                    )
                end,
                cwd = "${workspaceFolder}",
                stopAtEntry = true,
                setupCommands = {
                    {
                        text = "-enable-pretty-printing",
                        description = "enable pretty printing",
                        ignoreFailures = false,
                    },
                },
            },
        }

        require("dap-python").setup("uv")
    end,
}
