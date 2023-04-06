local lain     = require("lain")

-- require vars
local vars     = require("config.vars")

local terminal = lain.util.quake {
    app       = vars.terminal,
    name      = "TextScratchpad",
    argname   = "-t TextScratchpad",
    extra     = "--class TextScratchpad",
    followtag = true,
    vert      = "top",
    horiz     = "center",
    height    = 0.35,
    width     = 0.9
}

-- module table
return { terminal = terminal }
