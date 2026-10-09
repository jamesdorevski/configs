# Save command history
HISTFILE=~/.zsh_history
SAVEHIST=9999999
HISTSIZE=9999999
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

_zsh_dir="$HOME/repos/github/jamesdorevski/configs/zsh"

[[ $OSTYPE == darwin* ]] && source $_zsh_dir/.zsh_macos
source $_zsh_dir/.zsh_dotnet
source $_zsh_dir/.zsh_claude
source $_zsh_dir/.zsh_pyenv
source $_zsh_dir/.zsh_jenv
source $_zsh_dir/.zsh_plugins
source $_zsh_dir/.zsh_starship
source $_zsh_dir/.zsh_nvm
source $_zsh_dir/.zsh_yarn

for f in $_zsh_dir/functions/*.zsh(N); do source $f; done

source $_zsh_dir/.zsh_aliases

# must be placed last
source $_zsh_dir/.zsh_zoxide
