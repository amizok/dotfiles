-- onedark.lua
require('onedark').setup {
  style = 'warmer',
} require('onedark').load() -- kanagawa.lua
require('kanagawa').setup {
  colors = {
      fujiWhite = "#F7F7F7",
  },
}

-- nightfox.lua
require('nightfox').setup {
    options = {
    },
    specs = {
        all = {
            syntax = {
                bracket = "#F7F7F7",
                builtin0 = "green",
                -- builtin1 = "white",
                -- builtin2 = "",
                -- comment = "",
                conditional = "green",
                const = "green",
                -- dep = "pink",
                -- field = "pink",
                -- func = "pink",
                -- ident = "pink", keyword = "pink", number = "magenta",
                operator = "#F7F7F7",
                -- preproc = "pink",
                -- regex = "pink",
                -- statement = "pink",
                string = "yellow",
                -- type = "pink",
                -- variable = "#F7F7F7",
            }
        }
    },
    palettes = {
        all = {
            brack = "#000",
            -- red = "#F7F7F7",
            green = "#D1FA71",
            yellow = "#F6DC69",
            -- blue = "#F7F7F7",
            -- magenta = "#F7F7F7",
            -- cyan = "#F7F7F7",
            white = "#F7F7F7",
            -- orange = "#F7F7F7",
            -- pink = "#F7F7F7",
        },
    },
}
