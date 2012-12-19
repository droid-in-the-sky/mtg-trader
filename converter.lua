#!/usr/bin/env lua

local fin_name = 'current-magic-excel.txt'
local fin = assert(io.open(fin_name))

local fout_name = 'lua/cards.lua'
local fout = assert(io.open(fout_name,'w'))

fout:write('return {\n')

fin:read'*line'    -- first line is garbage

local n = 0
while true do
    local line = fin:read'*line'
    if not line then
        break
    end
    local name, price = string.match(line, '([^|]*)|([^|]*)')
    n = n + 1
    fout:write('\t{ n='..n..', price='..price..', name="'..name..'" },\n')
end

fout:write('}\n')
fout:close()

print(fin_name..' => '..fout_name)
print(n..' entries')
