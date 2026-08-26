-- 实现原理：与四轮最大胎压的差超阈值或低于下限的轮胎视为异常，再按异常数量输出。
local values = {}
for number in io.read("*l"):gmatch("%d+") do values[#values + 1] = tonumber(number) end
local maximum = math.max(values[1], values[2], values[3], values[4])
local bad = {}
for i = 1, 4 do
    if maximum - values[i] > values[6] or values[i] < values[5] then bad[#bad + 1] = i end
end
if #bad == 0 then
    print("Normal")
elseif #bad == 1 then
    print("Warning: please check #" .. bad[1] .. "!")
else
    print("Warning: please check all the tires!")
end
