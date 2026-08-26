-- 实现原理：多校尚有队员时循环分配相邻座位；只剩一校时座位号每次跳过一个。
local n = tonumber(io.read("*l"))
local teams, remaining, seats = {}, {}, {}
for token in io.read("*l"):gmatch("%d+") do teams[#teams + 1] = tonumber(token) end
for i = 1, n do remaining[i], seats[i] = teams[i] * 10, {} end
local seat = 1
local function active_count()
    local count = 0
    for i = 1, n do if remaining[i] > 0 then count = count + 1 end end
    return count
end
while active_count() > 1 do
    for i = 1, n do
        if remaining[i] > 0 then
            seats[i][#seats[i] + 1] = seat
            remaining[i], seat = remaining[i] - 1, seat + 1
        end
    end
end
for i = 1, n do
    while remaining[i] > 0 do
        seats[i][#seats[i] + 1] = seat
        remaining[i], seat = remaining[i] - 1, seat + 2
    end
end
for i = 1, n do
    print("#" .. i)
    for team = 1, teams[i] do
        local row = {}
        for player = 1, 10 do row[player] = seats[i][(team - 1) * 10 + player] end
        print(table.concat(row, " "))
    end
end
