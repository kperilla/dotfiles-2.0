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
 - Add install instructions to README
 - Add tmux
 - Add debugger support
 - Add test support
 - Add formatter support


# NOTES
 - I had to comment out the bash_profile TERM set for tmux to show colors properly
 - I have some code in tmux config

For my personal use :)

# Knowledge gaps
 - What's the deal with vim plugin config locations.
    - I.e. what's the deal with `after/` and `[ft]plugin`
    - Should I move my plugin config to make it simpler
 - How do you use the mason API?
    - Why are all the connector plugins so complicated?
 - I should try to understand all of kickstart.nvim

# Learning/wisdoms
 - Don't cheat yourself by learning with an AI code assistant
    - You'll never really internalize the language or tool or pattern, etc,
        You'll just be relying on the AI to be the part of your brain you
        are trying to grow
    - Go through the frustrations of not knowing and typing boilerplate manually
        that's the best way to actually learn
    - Then when you've learned a thing, and don't want to type it again,
        make a snippet for it! (if applicable)
    - Only use an AI when you're more concerned with efficiency than
        learning. (e.g.: like working your job)
