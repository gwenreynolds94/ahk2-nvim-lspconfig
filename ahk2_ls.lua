----- ahk2_ls.lua ------------------------------------------------
------------------------------------------------------------------

--- We'll use this to determine the root directory of the current file.
--- I recommend looking at the lspconfig docs to see what kind of functions
---     this provides. I'm just going to use `find_git_ancestor` here
local lsputil = require'lspconfig.util'

return {
    default_config = {
        cmd = {
            --- If node is in your path, you can just make this 'node', otherwise
            ---     specify the location of your node executable
            [[C:/Program Files/nodejs/node.exe]],
            --- Change this to fit wherever you've saved your ahk2 lsp.
            [[C:/Users/gwen/.cache/ahk2-lsp/server/dist/server.js]],
            [[--stdio]]
        },
        filetypes = { 'autohotkey' },
        single_file_support = true,
        root_dir = function(fname)
            --- backtrack up folder heirarchy and look for .git folder
            return lsputil.find_git_ancestor(fname)
        end,
        init_options = {
            ---@type
            ---| 'en-us'
            ---| 'zh-cn'
            locale = 'en-us',
            ---@type
            ---| 'Disabled'
            ---| 'Local'
            ---| 'User and Standard'
            ---| 'All'
            AutoLibInclude = 'Disabled',
            CommentTags = [[^;;\s*(?<tag>.+)]],
            CompleteFunctionParens = true,
            Diagnostics = {
                ClassStaticMemberCheck = true,
                ParamsCheck = true,
            },
            ActionWhenV1IsDetected = true,
            FormatOptions = {
                break_chained_methods = false,
                ignore_comment = false,
                indent_string = "\t",
                keep_array_indentation = true,
                max_preserve_newlines = 2,
                ---@type
                ---| '1'
                ---| '0'
                ---| '-1'
                one_true_brace = '1',
                preserve_newlines = true,
                space_after_double_colon = true,
                space_before_conditional = true,
                space_in_empty_paren = false,
                space_in_other = true,
                space_in_paren = false,
                wrap_line_length = 0,
            },
            --- Odds are you won't have to change this, but make sure
            InterpreterPath = [[C:/Program Files/AutoHotkey/v2/AutoHotkey.exe]],
            SymbolFoldingFromOpenBrace = false,
        },
    }
}
------------------------------------------------------------------
------------------------------------------------------------------
