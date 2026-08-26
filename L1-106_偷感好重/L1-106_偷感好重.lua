-- 实现原理：读取全量输入中所有整数（兼容单行/多行），取前三个求和；题面为嘴含+手拿+手捂三数之和，样例 2+1+3=6
local data = io.read("*a") or ""
local nums = {}
for x in data:gmatch("-?%d+") do nums[#nums+1] = tonumber(x) end
local sum = 0
for i = 1, math.min(3, #nums) do sum = sum + nums[i] end
-- 若输入不足3个数（健壮性），则对已有数求和；若多于3个数按题面仅取前3个
print(sum)
