CONF_DIR=$HOME/.config

if [ $SHELL_NAME == "zsh" ]; then
    RC_FILE=.zshrc
    PROFILE_FILE=.zprofile
elif [ $SHELL_NAME == "bash" ]; then
    RC_FILE=.bashrc
    PROFILE_FILE=.bash_profile
fi


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
if [ -f $HOME/$RC_FILE ]; then
    cp $HOME/$RC_FILE $CONF_DIR/backups
    rm $HOME/$RC_FILE
fi
if [ -d $HOME/$RC_FILE.d ]; then
    cp -r $HOME/$RC_FILE.d $CONF_DIR/backups
    rm -r $HOME/$RC_FILE.d
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
cp ./$RC_FILE $HOME/$RC_FILE
cp -r ./$RC_FILE.d $HOME/$RC_FILE.d
