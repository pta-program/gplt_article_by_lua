-- 实现原理：以标准体重为基准，比较真实体重是否落在其 90% 到 110% 的开区间内。
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local h, w = io.read("*l"):match("(%d+)%s+(%d+)")
    local standard = (tonumber(h) - 100) * 1.8 -- 换算为市斤
    w = tonumber(w)
    if math.abs(w - standard) < standard * 0.1 then
        print("You are wan mei!")
    elseif w > standard then
        print("You are tai pang le!")
    else
        print("You are tai shou le!")
    end
end
