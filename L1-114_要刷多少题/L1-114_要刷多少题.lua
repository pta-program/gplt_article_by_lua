-- 实现原理：每年15题共n年，总题量 = n*15；稳健读取全量输入的首个整数，参数化计算而非硬编码
local data = io.read("*a") or ""
local n = tonumber(data:match("-?%d+"))
if n then print(n * 15) end
