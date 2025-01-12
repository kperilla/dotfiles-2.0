setopt histignoredups
export EDITOR=nvim

for inc in "${HOME}"/.zshrc.d/*; do
    source "$inc"
done
