-- L2-045 堆宝塔
-- 实现原理：严格按题意维护 A、B 两个栈。A 中每次完成的一座塔记录层数；
-- 当无法把当前圆环放入 B 时，先结算 A，再将 B 中较大的圆环移回 A。

local n = io.read("*n")
local rings = {}
for i = 1, n do rings[i] = io.read("*n") end
local a, b, towers, highest = { rings[1] }, {}, 0, 0
local function finishA()
    if #a > 0 then towers = towers + 1; highest = math.max(highest, #a); a = {} end
end
for i = 2, n do
    local x = rings[i]
    if x < a[#a] then
        a[#a + 1] = x
    elseif #b == 0 or x > b[#b] then
        b[#b + 1] = x
    else
        finishA()
        while #b > 0 and b[#b] > x do a[#a + 1] = b[#b]; b[#b] = nil end
        a[#a + 1] = x
    end
end
finishA()
if #b > 0 then towers = towers + 1; highest = math.max(highest, #b) end
print(towers .. " " .. highest)
