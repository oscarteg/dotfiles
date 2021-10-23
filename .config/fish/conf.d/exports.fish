set -x EDITOR "nvim"

# Show hidden files ignore node_modules
set -x FZF_DEFAULT_COMMAND 'ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'

# Location Deno installation
set -x DENO_INSTALL "/Users/oscar/.deno"

# Dont open browser when using create react app
set -x BROWSER none
