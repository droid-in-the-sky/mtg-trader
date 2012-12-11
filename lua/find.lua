return function (cards, name)
    name = name:gsub('%s*$', '')
    local ret = {}
    for _, card in ipairs(cards) do
        if string.find(card.name:lower(), name:lower(), nil, true) then
            ret[#ret+1] = card
        end
    end
    return ret
end
