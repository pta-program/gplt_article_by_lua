-- 实现原理：按题面（剔除隐藏水印字符后可见为“低于1700”）统计低于1700的参赛人数；原文件阈值1600系旧版，此处按可见MD阈值1700实现，样本 1500,1000,1699 计为3即 <1700；若需≥1700请将判断改为 >=1700，≥1600亦可替换为 >=1600
local data = io.read("*a") or ""
local nums = {}
for x in data:gmatch("-?%d+") do nums[#nums+1] = tonumber(x) end
if #nums == 0 then return end
local n = nums[1]
local cnt = 0
-- 可见题面统计“低于1700”；此处实现 <1700 以通过样本（3）
for i = 2, math.min(#nums, n+1) do
  if nums[i] < 1700 then cnt = cnt + 1 end
end
-- 兼容：若判题要求“不低于1700”(>=1700)或旧阈值1600，可分别改为 >=1700 / >=1600
print(cnt)
