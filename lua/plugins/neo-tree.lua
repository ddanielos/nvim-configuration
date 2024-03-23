return {
    "nvim-neo-tree/neo-tree.nvim",
    tag = "3.6",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      --"domtronn/all-the-icons.el",
      "MunifTanjim/nui.nvim",

    },
    config = function()
      local neotree = require("neo-tree")
	  local do_setcd = function(state)
	     local p = state.tree:get_node().path
	     print(p) -- show in command line
	     vim.cmd(string.format('exec(":lcd %s")',p))
	  end
      neotree.setup({
        close_if_last_window = false,
        hide_root_node = true,
        retain_hidden_root_indent = false,
        enable_git_status = true,
        enable_modified_markers = false,
        use_popups_for_input = false, -- not ifloats for input
        enable_diagnostics = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            default = "*",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "✚",
              deleted   = "✖",
              modified  = "",
              renamed   = "",
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
        commands = {
            setcd = function(state)
				do_setcd(state)
            end,
            find_files = function(state)
				do_setcd(state)
				require('telescope.builtin').find_files()
            end,
            grep = function(state)
				do_setcd(state)
				require('telescope.builtin').live_grep()
            end,
        },
        window = {
          --c(d), z(p)
          mappings = {
            ["o"] = "open",
            ["a"] = "add",
            ["A"] = "add_directory",
            ["x"] = "close_node",
            ["u"] = "navigate_up",
            ["I"] = "toggle_hidden",
            ["C"] = "set_root",
            ["r"] = "refresh",
            ["c"] = "setcd",
            ["p"] = "find_files",
            ["g"] = "grep",
            ["<c-a>"] = {
              "add",
              config = {
                show_path = 'relative'
              }
            },
            ["<c-d>"] = "delete",
            ["<c-m>"] = {
              "move",
              config = {
                show_path = 'relative'
              }
            },
            ["<c-c>"] = {
              "copy",
              config = {
                show_path = 'relative'
              }
            },
            ["d"] = function() end,
            ["m"] = function() end,
            --["a"] = function() end,
            ["z"] = function() end,
          },
        },
        filesystem = {
          filtered_items = {
            show_hidden_count = false,
            hide_dotfiles = false,
          },
          components = {
            -- --hide file icon
            --icon = function(config, node, state)
              --if node.type == 'file' then
                  --return {
                    --text = "",
                    --highlight = config.highlight,
                  --}
              --end
              --return require('neo-tree.sources.common.components').icon(config, node, state)
            --end,
          } -- components
        }, -- filesystem
        event_handlers = {{
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.cmd [[
              setlocal relativenumber
            ]]
          end,
        }},
      })
      -- set keymaps
      local keymap = vim.keymap -- for conciseness
      local default_opts = {noremap=true, silent=true}
      keymap.set("n", "<leader>e", ":Neotree toggle filesystem right<CR>", default_opts)
      --keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem right<cr>")
      --keymap.set("n", "<space>e", "<cmd>Neotree filesystem reveal right<cr>")

  end,
}
