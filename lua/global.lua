ui_align = {    -- TODO other file
    left   = 0,     top    = 0,
    center = 1,     middle = 1,
    right  = 2,     bottom = 2,
}

local DIR
if UI_H < 400 then
    DIR = 'imgs/low'
elseif UI_H < 800 then
    DIR = 'imgs/medium'
else
    DIR = 'imgs/medium'
end

RES = {
    fnts = {
        { id='font_24', file='fnts/monofonto.ttf', size=1/24 },
        { id='font_20', file='fnts/monofonto.ttf', size=1/20 },
    },
    imgs = {
        { id='add',  file=DIR..'/add.png' },
        { id='find', file=DIR..'/find.png' },
        { id='mute', file=DIR..'/mute.png' },
        { id='l1',   file=DIR..'/l1.png' },
        { id='l2',   file=DIR..'/l2.png' },
        { id='rem',  file=DIR..'/rem.png' },
        { id='vs',   file=DIR..'/vs.png' },
    },
}

for i, res in ipairs(RES.fnts) do
    RES.fnts[res.id] = i
end
for i, res in ipairs(RES.imgs) do
    RES.imgs[res.id] = i
end

--[[
if ANDROID then
    CARDS = dofile '/data/data/org.droid_in_the_sky.mtg_trader/lib/lib_lua_cards.so'
else
    CARDS = dofile 'lua/cards.lua'
end
]]

t_remove = table.remove
L1 = {}
L2 = {}

local CLR = {
    brown     = { 0x40, 0x0D, 0x12 },
    darkgrey  = { 0x20, 0x20, 0x20 },
    lightgrey = { 0xCC, 0xCC, 0xCC },
}

local PAD_X = 1/50
local PAD_Y = 1/50

function find (name, limit)
    --name = name:gsub('%s*$', '')
    local ret = {}
    for _, card in ipairs(CARDS) do
        if string.find(card.name:lower(), name:lower(), nil, true) then
            ret[#ret+1] = card
            if #ret == limit then
                break
            end
        end
    end
    return ret
end

grid_main = {
    clr_bg = CLR.lightgrey,
    lay = {
        lins = 8,
        cols = 1,
        1, 2, 2, 2, 2, 2, 2, 2
    },
    uis = {
        {   -- BAR
            clr_bg = CLR.brown,
            pad_x = PAD_X,
            pad_y = PAD_Y,
            lay = {
                lins = 1,
                cols = 9,
                1, 2, 2, 2, 2, 3, 4, 5, 6
            },
            uis = {
                { img=RES.imgs.find },
                { },    -- textfield
                { img=RES.imgs.mute },
                { img=RES.imgs.vs   },
                { img=RES.imgs.l1 },
                { img=RES.imgs.l2 },
            },
        },
        {}, -- find,vs,l1,l2
    },
}

grid_vs = {
    clr_bg = CLR.darkgrey,
    pad_x = PAD_X,
    pad_y = PAD_Y,
    lay = {
        lins = 1,
        cols = 2,
        1, 2
    },
    uis = {
        { },
        { },
    },
}

function f_grid_tot (tot)
    return {
        clr_bg = CLR.lightgrey,
        clr_ui_bg = CLR.lightgrey,    -- long name vs price
        pad_x = PAD_X,
        pad_y = PAD_Y,
        lay = {
            lins = 7,
            cols = 1,
            1, 1, 1, 1, 1, 1, 2
        },
        uis = {
            { },    -- list
            {
                txt     = string.format("%.2f",tot),
                font    = { res=RES.fnts.font_20, color=CLR.darkgrey },
                align_x = 'right',
            },
        },
    }
end

function f_grid_list (t)
    local grid = {
        clr_ui_bg = CLR.lightgrey,    -- long name vs price
        one_y  = 1/10,
        pad_x  = PAD_X,
        pad_y  = PAD_Y,
        lay = {
            lins = #t,
            cols = 7,       -- name, price, rem
            -- 1,1,1,1,1, 2, 3
            -- ...
        },
        uis = {
            -- name, price, rem
            -- ...
        },
    }

    local tot = 0

    for i, card in ipairs(t) do
        local i0 = (i-1)*3

        -- 1,1,1,1,1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
        -- 2
            grid.lay[#grid.lay+1] = i0+2
        -- 3
            grid.lay[#grid.lay+1] = i0+3

        grid.uis[#grid.uis+1] = {
            txt     = card.name,
            font    = { res=RES.fnts.font_24, color=CLR.darkgrey },
            align_x = 'left',
        }

        tot = tot + card.price
        grid.uis[#grid.uis+1] = {
            txt     = string.format("%.2f",card.price),
            font    = { res=RES.fnts.font_24, color=CLR.darkgrey },
            align_x = 'right',
        }

        grid.uis[#grid.uis+1] = { img=RES.imgs.rem }
    end

    return grid, tot
end

function f_grid_find (name)
    local t = find(name, 30)

    local grid = {
        clr_ui_bg = CLR.lightgrey,    -- long name vs price
        one_y  = 1/10,
        pad_x  = PAD_X,
        pad_y  = PAD_Y,
        lay = {
            lins = #t,
            cols = 9,   -- name, price, l1, l2
            -- 1,1,1,1,1,1, 2, 3,4
            -- ...
        },
        uis = {
            -- name, price, +, +
            -- ...
        },
    }

    for i, card in ipairs(t) do
        local i0 = (i-1)*4

        -- 1,1,1,1,1,1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
            grid.lay[#grid.lay+1] = i0+1
        -- 2
            grid.lay[#grid.lay+1] = i0+2
        -- 3,4
            grid.lay[#grid.lay+1] = i0+3
            grid.lay[#grid.lay+1] = i0+4

        grid.uis[#grid.uis+1] = {
            txt     = card.name,
            font    = { res=RES.fnts.font_24, color=CLR.darkgrey },
            align_x = 'left',
        }

        grid.uis[#grid.uis+1] = {
            txt     = string.format("%.2f",card.price),
            font    = { res=RES.fnts.font_24, color=CLR.darkgrey },
            align_x = 'right',
        }

        grid.uis[#grid.uis+1] = { img=RES.imgs.add }
        grid.uis[#grid.uis+1] = { img=RES.imgs.add }
    end

    return t, grid
end
