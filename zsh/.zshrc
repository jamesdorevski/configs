# Source aliases
[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases

# dotnet
export PATH=$PATH:$HOME/.dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT/tools

# dotnet x64
export PATH=$PATH:$HOME/.dotnet64
alias dotnet64=$HOME/.dotnet64/dotnet

# Pyenv
export PYENV_ROOT=$HOME/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Zoxide
alias cd=z
eval "$(zoxide init zsh)"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -s "$HOMEBREW_PREFIX/opt/jabba/jabba.sh" ] && . "$HOMEBREW_PREFIX/opt/jabba/jabba.sh"

# Starship
eval "$(starship init zsh)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ZSH plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
eval "$(/Users/james/.local/bin/mise activate zsh)"
