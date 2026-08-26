-- 实现原理：女方身高乘 1.09 得男方身高；男用户反向除以 1.09 求女方身高。
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local gender, height = io.read("*l"):match("(%S+)%s+([%d.]+)")
    height = tonumber(height)
    local partner = gender == "M" and height / 1.09 or height * 1.09
    print(string.format("%.2f", partner))
end
