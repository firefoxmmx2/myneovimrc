return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set("x", "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode…" })
      vim.keymap.set("n", "<leader>oa", function()
        require("opencode").ask("", { submit = true })
      end, { desc = "Ask opencode (no context)" })

      vim.keymap.set("n", "<leader>oi", function()
        require("opencode").command("session.interrupt")
        require("opencode").command("session.interrupt")
      end, { desc = "Interrupt opencode command" })

      vim.keymap.set({ "n", "x" }, "<leader>ox", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function()
        require("opencode").prompt("@this ")
      end, { desc = "Add range to opencode" })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("session.half.page.up")
      end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("session.half.page.down")
      end, { desc = "Scroll opencode down" })

      vim.keymap.set("n", "<leader>oc", function()
        require("opencode").command("prompt.clear")
      end, { desc = "Clear opencode prompt" })

      vim.keymap.set("n", "<leader>on", function()
        require("opencode").command("session.new")
      end, { desc = "New opencode session" })

      vim.keymap.set("n", "<leader>ou", function()
        require("opencode").command("session.undo")
      end, { desc = "Undo opencode session" })

      vim.keymap.set("n", "<leader>or", function()
        require("opencode").command("session.redo")
      end, { desc = "Redo opencode session" })

      vim.keymap.set("n", "<leader>o<Tab>", function()
        require("opencode").command("agent.cycle")
      end, { desc = "Toggle opencode agent" })
    end,
  },
}
