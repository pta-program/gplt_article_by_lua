-- 实现原理：每个骰子从 6 向下挑选未出现过的最大点数；初始点数也属于已出现集合。
local dice = {}
for value in io.read("*l"):gmatch("%d+") do dice[#dice + 1] = tonumber(value) end
local rounds = tonumber(io.read("*l"))
for i = 1, 6 do
    local used, value = { [dice[i]] = true }, 6
    for _ = 1, rounds do
        while used[value] do value = value - 1 end
        used[value] = true
        if _ == rounds then dice[i] = value end
        value = value - 1
    end
end
print(table.concat(dice, " "))
