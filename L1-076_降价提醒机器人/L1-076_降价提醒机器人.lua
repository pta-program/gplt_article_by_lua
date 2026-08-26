-- 实现原理：逐条比较当前价格与设置价格，严格更低才提示。
local n, limit = io.read("*l"):match("(%d+)%s+(%d+)")
for _ = 1, tonumber(n) do
    local price = tonumber(io.read("*l"))
    if price < tonumber(limit) then print(string.format("On Sale! %.1f", price)) end
end
