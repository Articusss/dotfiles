return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local config = require "nvchad.configs.cmp"
      local cmp = require "cmp"

      config.mapping["<CR>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = false,
      }

      config.completion = {
        completeopt = "menu,menuone,noselect",
      }

      config.preselect = cmp.PreselectMode.None

      return config
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"williamboman/mason.nvim",
  	opts = {
  	ensure_installed = {
  	  "lua-language-server", "stylua",
  	  "html-lsp", "css-lsp" , "prettier",
      "pyright", "clangd", "typescript-language-server",
		  },
    },
  },

  {
  	"nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "javascript", "typescript",
        "c", "cpp", "python", "markdown", "markdown_inline"
        },
      },
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "uni",
          path = "~/vaults/uni",
        },

        {
          name = "personal",
          path = "~/vaults/personal",
        },
      },
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      wiki_link_func = "use_alias_only",
    },
  },
}
