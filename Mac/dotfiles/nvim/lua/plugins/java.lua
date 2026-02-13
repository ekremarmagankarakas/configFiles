return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = {
		"mason-org/mason.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		local jdtls = require("jdtls")
		local mason_registry = require("mason-registry")

		-- Paths
		local jdtls_pkg = mason_registry.get_package("jdtls")
		local jdtls_path = jdtls_pkg:get_install_path()
		local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

		-- Platform config
		local os_name = vim.uv.os_uname().sysname
		local config_dir
		if os_name == "Darwin" then
			config_dir = jdtls_path .. "/config_mac"
		elseif os_name == "Linux" then
			config_dir = jdtls_path .. "/config_linux"
		else
			config_dir = jdtls_path .. "/config_win"
		end

		-- Per-project workspace directory
		local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
		local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

		-- DAP bundles (java-debug-adapter + java-test)
		local bundles = {}

		local function add_bundles(pkg_name, pattern)
			if mason_registry.is_installed(pkg_name) then
				local pkg_path = mason_registry.get_package(pkg_name):get_install_path()
				local jars = vim.fn.glob(pkg_path .. pattern, true, true)
				for _, jar in ipairs(jars) do
					if not vim.endswith(jar, "com.microsoft.java.test.runner-jar-with-dependencies.jar") then
						table.insert(bundles, jar)
					end
				end
			end
		end

		add_bundles("java-debug-adapter", "/extension/server/com.microsoft.java.debug.plugin-*.jar")
		add_bundles("java-test", "/extension/server/*.jar")

		-- Capabilities (share with nvim-cmp)
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if ok_cmp then
			capabilities = cmp_lsp.default_capabilities(capabilities)
		end

		-- JDTLS config
		local config = {
			cmd = {
				"java",
				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
				"-Dosgi.bundles.defaultStartLevel=4",
				"-Declipse.product=org.eclipse.jdt.ls.core.product",
				"-Dlog.protocol=true",
				"-Dlog.level=ALL",
				"-Xmx1g",
				"--add-modules=ALL-SYSTEM",
				"--add-opens",
				"java.base/java.util=ALL-UNNAMED",
				"--add-opens",
				"java.base/java.lang=ALL-UNNAMED",
				"-jar",
				launcher,
				"-configuration",
				config_dir,
				"-data",
				workspace_dir,
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
			capabilities = capabilities,
			settings = {
				java = {
					eclipse = { downloadSources = true },
					configuration = { updateBuildConfiguration = "interactive" },
					maven = { downloadSources = true },
					implementationsCodeLens = { enabled = true },
					referencesCodeLens = { enabled = true },
					references = { includeDecompiledSources = true },
					signatureHelp = { enabled = true },
					format = { enabled = true },
					completion = {
						favoriteStaticMembers = {
							"org.hamcrest.MatcherAssert.assertThat",
							"org.hamcrest.Matchers.*",
							"org.hamcrest.CoreMatchers.*",
							"org.junit.jupiter.api.Assertions.*",
							"java.util.Objects.requireNonNull",
							"java.util.Objects.requireNonNullElse",
							"org.mockito.Mockito.*",
						},
						filteredTypes = {
							"com.sun.*",
							"io.micrometer.shaded.*",
							"java.awt.*",
							"jdk.*",
							"sun.*",
						},
					},
					sources = {
						organizeImports = {
							starThreshold = 9999,
							staticStarThreshold = 9999,
						},
					},
				},
			},
			init_options = {
				bundles = bundles,
			},
			on_attach = function(_, bufnr)
				-- Enable DAP integration after LSP attaches
				jdtls.setup_dap({ hotcodereplace = "auto" })

				local function nmap(lhs, rhs, desc)
					vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = desc })
				end

				-- Java-specific keymaps
				nmap("<leader>jo", jdtls.organize_imports, "Organize imports")
				nmap("<leader>jev", jdtls.extract_variable, "Extract variable")
				nmap("<leader>jec", jdtls.extract_constant, "Extract constant")
				nmap("<leader>jem", jdtls.extract_method, "Extract method")
				nmap("<leader>jtm", jdtls.test_nearest_method, "Test nearest method")
				nmap("<leader>jtc", jdtls.test_class, "Test class")

				-- Visual mode extract
				vim.keymap.set("v", "<leader>jev", function()
					jdtls.extract_variable(true)
				end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract variable" })
				vim.keymap.set("v", "<leader>jec", function()
					jdtls.extract_constant(true)
				end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract constant" })
				vim.keymap.set("v", "<leader>jem", function()
					jdtls.extract_method(true)
				end, { noremap = true, silent = true, buffer = bufnr, desc = "Extract method" })
			end,
		}

		-- Attach jdtls via autocmd (runs for every Java buffer)
		local jdtls_group = vim.api.nvim_create_augroup("JdtlsAttach", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = jdtls_group,
			pattern = "java",
			callback = function()
				jdtls.start_or_attach(config)
			end,
		})

		-- Start immediately if we're already in a Java buffer
		if vim.bo.filetype == "java" then
			jdtls.start_or_attach(config)
		end
	end,
}
