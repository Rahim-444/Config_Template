local config = {

	cmd = { "/Users/mac/.local/share/jdt/bin/jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "bin", "gradlew", ".git", "mvnw" }, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
