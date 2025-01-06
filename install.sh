CONF_DIR=$HOME/.config

################
# backups
################
echo "Backing up old configurations to $CONF_DIR/backups..."
if [ ! -d $CONF_DIR/backups ]; then
  mkdir $CONF_DIR/backups
fi
if [ -d $CONF_DIR/nvim ]; then
  cp -r $CONF_DIR/nvim $CONF_DIR/backups
  rm -r $CONF_DIR/nvim
fi

#################
# config defaults
#################
if [ ! -f ./nvim/lua/kevin/my_lsp_servers.lua ]; then
  cp ./nvim/lua/kevin/my_lsp_servers.lua.template ./nvim/lua/kevin/my_lsp_servers.lua
fi

################
# move files
################
echo "Installing config files..."
cp -r ./nvim $CONF_DIR/nvim
