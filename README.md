Config files

NeoVim config stolen from this video [ThePrimeagen's "0 to LSP : Neovim RC From Scratch"](https://www.youtube.com/watch?v=w7i4amO_zaE)

# Prerequisites
 - Neovim
 - Ripgrep
 - You need to set up your SSH key to your own Github account or the mason
 installs will fail
 - xclip for clipboard access (I haven't figured it out for ssh though)
 - Create a file `lua/kevin/my_lsp_servers.lua` with the LSP servers you want
    - Format:
```
return {
    -- Replace these with whatever servers you want to install
    -- 'rust_analyzer',
    -- 'tsserver',
    -- 'csharp_ls',
    -- 'omnisharp',
    -- 'pyright',
    -- 'lua_ls',
    -- 'gopls',
    -- 'dockerls',
}
```
 - (If you're into that sort of thing...), for AI completion with Codeium,
 uncomment the line in for `codeium.vim` in `nvim/lua/plugins/init.lua`,
 then after install, run `:Codeium Auth`

# TODO
 - Make install use logical links
 - Add install instructions to README
 - Add tmux
 - Add debugger support
 - Add test support
 - Add formatter support

# NOTES
 - I had to comment out the bash_profile TERM set for tmux to show colors properly
 - I have some code in tmux config
