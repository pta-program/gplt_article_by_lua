-- 实现原理：计算寿命 d=B-A并分类：d>250 输出 jiu ting tu ran de...，d<=0 输出 hai sheng ma?，否则 nin tai cong ming le!
local data = io.read("*a") or ""
local nums = {}
for x in data:gmatch("-?%d+") do nums[#nums+1] = tonumber(x) end
local A = nums[1] or 0
local B = nums[2] or 0
local d = B - A
print(d)
if d > 250 then
  print("jiu ting tu ran de...")
elseif d <= 0 then
  print("hai sheng ma?")
else
  print("nin tai cong ming le!")
end
