-- 实现原理：将金额向下取为不超过它的最大 2 的幂，等价于不断翻倍直到下一次会超过原数。
local n=tonumber(io.read("*l")); local value=1; while value*2<=n do value=value*2 end; print(value)
