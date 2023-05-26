## AutoHotkey v2 configuration for **thqby's** lsp using **nvim-lspconfig**

There may be a better way to do this without manually placing the server
configuration in lspconfig's plugin folder, but this is what I've got and 
it does work, so...

Follow the 
[instructions](https://github.com/thqby/vscode-autohotkey2-lsp#use-in-other-editors) 
from thqby's extension README to download/install the language server and 
place it wherever you want it to stay. If you already have an existing
installation, the minimum version required is 1.9.1 
(unless you have a really old version)

----

### First, find the plugin folder for lspconfig.

*For me*, this is at 
`C:\Users\%USERNAME%\.local\share\nvim-data\site\pack\packer\start\nvim-lspconfig` 
but the default location on Windows, *using Packer*, is 
`%LOCALAPPDATA%\nvim-data\site\pack\packer\start\nvim-lspconfig`

The nvim-lspconfig folder will most likely be a descendant of 
`%LOCALAPPDATA\nvim-data\site\pack` with windows and 
`~/.local/share/nvim-data/site/pack` with Unix. Mine is also under 
`packer\start` since I installed it with Packer. You just have to find out 
where your plugins are installed according to your package manager.

Next, the `nvim-lspconfig\lua` folder is where you want to be. 
Inside this folder, you've got:

```
.\lspconfig\
    server_configurations\
        als.lua
        anakin_language_server.lua
        angularls.lua
        ansiblels.lua
        ...
    ui\
        lspinfo.lua
        windows.lua
    configs.lua
    util.lua
.\lspconfig.lua
```
lspconfig uses the files in the `server_configurations` folder to provide
setup functions. The name of the file in `server_configurations` is what you use
to retrieve the function in your lua code: 
```lua
require[[lspconfig]].<filename>.setup()
```

----

### Add a new server configuration

You can just drop `ahk2_ls.lua` in `nvim-lspconfig/lua/lspconfig/server_configurations`. 
But you may want to go ahead and change some values here so you don't have to do 
it when you call the setup function. This is just creating a default configuration 
so that lspconfig will provide a setup function. There are some options for formatting, 
comment tags, which libraries to auto-include, etc. There are comments and annotations 
in the `ahk2_ls.lua` file provided; just give it a look. 

----

### Call setup function

I like to create wrappers for my plugin setup functions. So I have something 
akin to what's in the `lspconfig_setup.lua` file. If you placed it in nvim/lua, 
then in your nvim/init.lua, you'd just need to add:
```lua
require'lspconfig_setup'.setup_ahk2_ls()
```

The reason I make a wrapper for it is so I can require my setup file and make changes 
to the setup options before I call the setup function, just in case I want to change
something from my init.lua instead of the required file, eg. »

```lua
local lspconf = require'lspconfig_setup'
lspconf.ahk2_setup_options.init_options.FormatOptions.max_preserve_newlines = 3
lspconf.setup_ahk2_ls()
```

It's totally unnecessary though, so you know, adapt it to fit your own configurations.
