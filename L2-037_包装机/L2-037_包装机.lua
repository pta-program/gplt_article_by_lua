-- L2-037 包装机
-- 实现原理：每条轨道用下标模拟队列，筐用数组模拟栈。
-- 按轨道键时若筐已满，先强制弹出栈顶；按 0 键则仅弹出栈顶到流水线。

local raw = io.read("*a")
if not raw or raw:match("^%s*$") then return end
local toks = {}
for tok in raw:gmatch("%S+") do toks[#toks+1] = tok end
local p = 1
local function nt() p = p + 1; return toks[p-1] end
local function ni() local t = nt(); return t and tonumber(t) end
local n, m, limit = ni(), ni(), ni()
local tracks, nextPos = {}, {}
for i = 1, n do tracks[i] = nt(); nextPos[i] = 1 end
local basket, output = {}, {}
while true do
    local button = ni()
    if not button or button == -1 then break end
    if button == 0 then
        if #basket > 0 then output[#output + 1] = basket[#basket]; basket[#basket] = nil end
    elseif nextPos[button] <= m then
        if #basket == limit then output[#output + 1] = basket[#basket]; basket[#basket] = nil end
        basket[#basket + 1] = tracks[button]:sub(nextPos[button], nextPos[button])
        nextPos[button] = nextPos[button] + 1
    end
end
print(table.concat(output))
