-- 实现原理：优先判断乘法结果，其次判断加法结果，否则为第三种结论。
local n = tonumber(io.read("*l"))
for _ = 1, n do local a,b,c=io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)"); a,b,c=tonumber(a),tonumber(b),tonumber(c); if c==a*b then print("Lv Yan") elseif c==a+b then print("Tu Dou") else print("zhe du shi sha ya!") end end
