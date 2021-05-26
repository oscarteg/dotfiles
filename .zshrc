# Path to your oh-my-zsh installation.
export ZSH="/Users/oscar/.oh-my-zsh"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
for file in ~/.{exports,path,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Zsh theme
ZSH_THEME="minimal"

# Zsh plugins
plugins=(docker terraform git kubectl docker-compose vagrant zsh-autosuggestions autojump rust cargo)

# Source oh my zsh
source $ZSH/oh-my-zsh.sh

# Source NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Add the fuck to shell
eval $(thefuck --alias)

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"




autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
