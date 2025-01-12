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
if [ -f $HOME/$RC_FILE ]; then
    cp $HOME/$RC_FILE $CONF_DIR/backups
    rm $HOME/$RC_FILE
fi
if [ -d $HOME/$RC_FILE.d ]; then
    cp -r $HOME/$RC_FILE.d $CONF_DIR/backups
    rm -r $HOME/$RC_FILE.d
fi


################
# link files
################
echo "Installing config files..."
ln -sf "$(pwd)/$RC_FILE" $HOME/$RC_FILE
ln -sf "$(pwd)/$RC_FILE.d" $HOME/$RC_FILE.d

bash ./install_scripts/nvim_install.sh
bash ./install_scripts/tmux_install.sh
