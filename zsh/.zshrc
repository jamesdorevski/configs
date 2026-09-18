[ -f ~/.zsh_aliases ] && source ~/.zsh_aliases
[ -f ~/.zsh_secrets ] && source ~/.zsh_secrets

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
[ -s "$HOMEBREW_PREFIX/opt/jabba/jabba.sh" ] && . "$HOMEBREW_PREFIX/opt/jabba/jabba.sh"

# Add libpq to PATH
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Prefer GNU coreutils over macOS default
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Pyenv
export PYENV_ROOT=$HOME/.pyenv
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Zoxide
alias cd=z
eval "$(zoxide init zsh)"

# ZSH plugins
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
eval "$(/Users/james/.local/bin/mise activate zsh)"

# ZSH Vi mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

