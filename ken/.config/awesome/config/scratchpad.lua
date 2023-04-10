local lain = require("lain")

-- require vars
local vars = require("config.vars")

-- module table
return {
    terminal = function(name, s)
        return lain.util.quake {
            app     = vars.terminal,
            name    = name,
            argname = "-t " .. name,
            extra   = "--class " .. name,
            vert    = "top",
            horiz   = "center",
            height  = 0.35,
            width   = 0.9,
            screen  = s
        }
    end
}
