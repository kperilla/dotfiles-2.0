setopt histignoredups

for inc in "${HOME}"/.zshrc.d/*; do
    source "$inc"
done
