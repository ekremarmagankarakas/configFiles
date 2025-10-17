-- ./lua/plugins/lsp-config.lua  (Neovim 0.11+ / new API)
return {
  "neovim/nvim-lspconfig",
  version = "*",
  dependencies = {
    -- LSP + Mason
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      -- IMPORTANT: drop old commit pin & handlers; use opts with automatic_enable
      opts = {
        ensure_installed = { "lua_ls", "pylsp", "ts_ls", "zls", "ltex" },
        automatic_enable = true, -- uses vim.lsp.enable() for installed servers
      },
    },
    "j-hui/fidget.nvim",

    -- Formatting
    "stevearc/conform.nvim",

    -- Completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    --------------------------------------------------------------------------
    -- Conform (kept as-is)
    --------------------------------------------------------------------------
    local conform = require("conform")
    local util = require("conform.util")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_fix", "ruff_format" },
        cpp = { "clang-format" },
        javascript = { "eslint_d", "prettier" },
        typescript = { "eslint_d", "prettier" },
        typescriptreact = { "eslint_d", "prettier" },
        javascriptreact = { "eslint_d", "prettier" },
      },
      formatters = {
        ruff_fix = {
          command = "ruff",
          args = { "check", "--fix", "--stdin-filename", "$FILENAME", "-" },
          stdin = true,
        },
        ruff_format = {
          command = "ruff",
          args = { "format", "--stdin-filename", "$FILENAME" },
          stdin = true,
        },
        prettier = { prepend_args = { "--tab-width", "2", "--use-tabs", "false" } },
        stylua = { prepend_args = { "--indent-width", "4" } },
        eslint_d = {
          command = "eslint_d",
          stdin = false,
          args = { "--fix", "--stdin-filename", "$FILENAME", "$FILENAME" },
          condition = function(ctx)
            if vim.fn.executable("eslint_d") ~= 1 then return false end
            return util.root_file({
              ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json",
              "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs",
              "eslint.config.ts", "eslint.config.mts", "eslint.config.cts",
            }, ctx.buf) ~= nil
          end,
        },
      },
      default_formatter = "prettier",
      log_level = vim.log.levels.DEBUG,
    })

    vim.keymap.set("n", "<leader>lf", function() conform.format() end,
      { noremap = true, silent = true, desc = "Format file" })

    --------------------------------------------------------------------------
    -- CMP (kept, minimal)
    --------------------------------------------------------------------------
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")

    cmp.setup({
      snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, { name = "luasnip" },
      }, { { name = "buffer" } }),
    })

    --------------------------------------------------------------------------
    -- Diagnostics + toggles (kept, with small enhancements)
    --------------------------------------------------------------------------
    vim.diagnostic.config({
      virtual_text = false,
      underline = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    local function nn(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
    end

    local vt_on, ul_on, cmp_on = false, true, true

    nn("<leader>lee", function()
      vt_on = not vt_on
      vim.diagnostic.config({ virtual_text = vt_on })
      vim.notify("Virtual text: " .. (vt_on and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
    end, "Diagnostics: toggle virtual text")

    nn("<leader>leu", function()
      ul_on = not ul_on
      vim.diagnostic.config({ underline = ul_on })
      vim.notify("Underline: " .. (ul_on and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
    end, "Diagnostics: toggle underline")

    nn("<leader>ltc", function()
      cmp_on = not cmp_on
      cmp.setup({ enabled = cmp_on })
      vim.notify("Suggestions: " .. (cmp_on and "ENABLED" or "DISABLED"), vim.log.levels.INFO)
    end, "Toggle nvim-cmp suggestions")

    --------------------------------------------------------------------------
    -- LSP (new API) ----------------------------------------------------------
    --------------------------------------------------------------------------
    require("fidget").setup()

    -- 1) Advertise cmp capabilities to ALL servers (wildcard)
    vim.lsp.config("*", {
      capabilities = cmp_lsp.default_capabilities(),
    })

    -- 2) Server-specific settings (new API)
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "Lua 5.1" },
          diagnostics = { globals = { "bit", "vim", "it", "describe", "before_each", "after_each" } },
          workspace = { checkThirdParty = false },
        },
      },
    })

    vim.lsp.config("pylsp", {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = { enabled = false },
            pyflakes    = { enabled = false },
            mccabe      = { enabled = false },
            flake8      = { enabled = false },
            yapf        = { enabled = false },
            autopep8    = { enabled = false },
            -- ruff via Conform (ruff_fix/ruff_format)
          },
        },
      },
    })

    vim.lsp.config("ltex", {
      settings = {
        ltex = {
          checkFrequency = "save",
          language = "en-US",
          enabled = { "markdown", "text", "tex" },
          disabledRules = { ["en-US"] = { "WHITESPACE_RULE" } },
        },
      },
    })

    vim.lsp.config("zls", {
      -- If you need to override root_dir, do it here; otherwise zls config provides defaults.
      settings = {
        zls = {
          enable_inlay_hints = true,
          enable_snippets = true,
          warn_style = true,
        },
      },
    })

    -- 3) Buffer-local keymaps & formatting policy when a client attaches
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local enc = (client and client.offset_encoding) or "utf-16"

        -- Let Conform own formatting for these
        if client and (client.name == "lua_ls" or client.name == "pylsp"
          or client.name == "ts_ls" or client.name == "tsserver") then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        local function nmap(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
        end

        nmap("<leader>ld",  vim.lsp.buf.hover, "Hover")
        nmap("<leader>lrn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>lca", vim.lsp.buf.code_action, "Code Action")
        nmap("<leader>le",  function() vim.diagnostic.open_float(nil, { focusable = false }) end, "Diagnostics Float")

        -- Definition in vsplit; Telescope if multiple; QF fallback
        local function qf_from_locations(locs, title)
          local items = vim.lsp.util.locations_to_items(locs, enc)
          vim.fn.setqflist({}, " ", { title = title or "LSP results", items = items })
          vim.cmd("copen")
        end

        local function open_definition_vsplit()
          vim.lsp.buf_request(
            bufnr,
            "textDocument/definition",
            vim.lsp.util.make_position_params(),
            function(err, result)
              if err then
                vim.notify("LSP definition error: " .. (err.message or ""), vim.log.levels.ERROR)
                return
              end
              if not result or (type(result) == "table" and vim.tbl_isempty(result)) then
                vim.notify("No definition found", vim.log.levels.INFO)
                return
              end

              local results = vim.tbl_islist(result) and result or { result }

              if #results > 1 then
                local ok_tb, tb = pcall(require, "telescope.builtin")
                if ok_tb then
                  local themes = require("telescope.themes")
                  tb.lsp_definitions(themes.get_dropdown({}))
                  return
                else
                  qf_from_locations(results, "LSP Definitions")
                  return
                end
              end

              vim.cmd("vsplit | wincmd l")
              vim.lsp.util.jump_to_location(results[1], enc)
            end
          )
        end

        nmap("<leader>lgd", open_definition_vsplit, "Definition (vsplit)")

        -- Telescope implementations/references with graceful fallback
        do
          local ok_tb, tb = pcall(require, "telescope.builtin")
          if ok_tb then
            local dd = require("telescope.themes").get_dropdown
            nmap("<leader>lgi", function() tb.lsp_implementations(dd({})) end, "Implementations (Telescope)")
            nmap("<leader>lgr", function() tb.lsp_references(dd({ include_declaration = false })) end, "References (Telescope)")
          else
            nmap("<leader>lgi", vim.lsp.buf.implementation, "Implementations")
            nmap("<leader>lgr", vim.lsp.buf.references, "References")
          end
        end
      end,
    })
  end,
}

