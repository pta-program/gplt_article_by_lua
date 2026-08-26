-- 实现原理：两堆栈模拟姥姥改作业，S左存c_i>T者，S右存已批改，按T=floor(平均)迭代，LIFO顺序取左堆
local data = io.read("*a")
if not data then return end
local nums = {}
for s in data:gmatch("-?%d+") do nums[#nums+1]=tonumber(s) end
if #nums < 2 then return end
local n = nums[1]
local T = nums[2]
local c = {}
for i = 1, n do c[i] = nums[2+i] or 0 end
-- pending 为待批改堆自顶向下（1为顶）
local pending = {}
for i = 1, n do pending[i]=i end
local result = {}
local curT = T
while #pending > 0 do
    local left = {}
    local nextRight = {}
    for idx = 1, #pending do
        local id = pending[idx]
        if c[id] > curT then
            left[#left+1]=id
        else
            result[#result+1]=id
        end
    end
    if #left == 0 then break end
    local sum = 0
    for _, id in ipairs(left) do sum = sum + c[id] end
    curT = math.floor(sum / #left)
    -- 下一轮待批改为 left 栈顶优先，即逆序
    pending = {}
    for i = #left, 1, -1 do pending[#pending+1]=left[i] end
end
-- 若仍有未输出（理论上已全部输出），补充
if #result > 0 then
    local out = {}
    for _, v in ipairs(result) do out[#out+1]=tostring(v) end
    print(table.concat(out, " "))
else
    print("")
end
