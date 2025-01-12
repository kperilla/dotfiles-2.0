CONF_DIR=$HOME/.config

echo "Backing up old Tmux configurations to $CONF_DIR/backups..."
if [ -f $HOME/.tmux.conf ]; then
    cp $HOME/.tmux.conf $CONF_DIR/backups
    rm $HOME/.tmux.conf
fi

echo "Installing Tmux config files..."
ln -sf "$(pwd)/tmux/.tmux.conf" $HOME/.tmux.conf
