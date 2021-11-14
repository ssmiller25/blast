# Gitpod bashrc - may replace with my containered "dotfiles" later at some point...but later...

# kubectl shortcuts

source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
alias k=kubectl
complete -F __start_kubectl k