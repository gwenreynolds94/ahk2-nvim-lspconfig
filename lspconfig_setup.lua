----- lspconfig_setup.lua ----------------------------------------
local L = {}
------------------------------------------------------------------

L.ahk2_setup_options = {
    cmd = {
        [[node]],
        [[C:\Users\gwenreynolds94\.cache\ahk2-lsp\server\dist\server.js]],
        [[--stdio]]
    },
    init_options = {
        AutoLibInclude = 'All'
    }
}

function L.setup_ahk2_ls()

    --- _G.jk is a variable I use to store some global user configurations.
    --- So just get rid of the if/elseif and use the contents of the branch
    --- that applies to you. I've only used cmp and coq so that's all I have
    --- mine set up for.
    if (_G.jk and _G.jk.use_cmp) then --- SETUP CMP CAPABILITIES
        --- I was actually doing something else for cmp but I looked it up
        --- and this seems to be the proper way to do things. But I *was* just
        --- setting <options>.capabilities to:
        ---     require'cmp_nvim_lsp'.default_capabilities()
        local _capabilities = vim.lsp.protocol.make_client_capabilities()
        local cmp_capabilities = require'cmp_nvim_lsp'.update_capabilities(_capabilities)
        L.ahk2_setup_options.capabilities = cmp_capabilities
    elseif (_G.jk and _G.jk.use_coq) then --- SETUP COQ CAPABILITIES
        local coq_capabilities = require'coq'.lsp_ensure_capabilities(L.ahk2_setup_options)
        L.ahk2_setup_options.capabilities = coq_capabilities
    end

    --- `ahk2_ls` corresponds to the filename of the server configuration you added
    require[[lspconfig]].ahk2_ls.setup(L.ahk2_setup_options)

end

------------------------------------------------------------------
return L
------------------------------------------------------------------
