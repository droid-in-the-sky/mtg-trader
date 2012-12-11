local fin  = assert(io.open'current-magic-excel.txt')
local fout = assert(io.open('list.lua','w'))

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
