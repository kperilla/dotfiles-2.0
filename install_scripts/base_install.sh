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
# move files
################
echo "Installing config files..."
cp ./$RC_FILE $HOME/$RC_FILE
cp -r ./$RC_FILE.d $HOME/$RC_FILE.d

source ./install_scripts/nvim_install.sh
