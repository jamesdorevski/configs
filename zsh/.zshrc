[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

[[ $OSTYPE == darwin* ]] && source $_zsh_dir/.zsh_macos
[[ $OSTYPE == (msys|cygwin)* ]] && source $_zsh_dir/.zsh_msys
source $_zsh_dir/.zsh_dotnet
source $_zsh_dir/.zsh_pyenv
source $_zsh_dir/.zsh_jenv
source $_zsh_dir/.zsh_zoxide
source $_zsh_dir/.zsh_plugins
source $_zsh_dir/.zsh_starship

for f in $_zsh_dir/functions/*.zsh(N); do source $f; done
source $_zsh_dir/.zsh_aliases
