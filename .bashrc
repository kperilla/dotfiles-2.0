alias gs="git status"
alias gd="git diff"
alias gdc="git diff --cached"

for inc in "${HOME}"/.bashrc.d/*; do
    source "$inc"
done
