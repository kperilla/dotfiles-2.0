CONF_DIR=$HOME/.config

echo "Backing up old Neovim configurations to $CONF_DIR/backups..."
if [ -d $CONF_DIR/nvim ]; then
    cp -r $CONF_DIR/nvim $CONF_DIR/backups
    rm -r $CONF_DIR/nvim
fi
if [ ! -f ./nvim/lua/kevin/my_lsp_servers.lua ]; then
    cp ./nvim/lua/kevin/my_lsp_servers.lua.template ./nvim/lua/kevin/my_lsp_servers.lua
fi

echo "Installing Neovim config files..."
ln -sf "$(pwd)/nvim" $CONF_DIR/nvim
