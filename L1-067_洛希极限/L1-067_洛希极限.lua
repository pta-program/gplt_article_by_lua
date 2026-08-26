-- 实现原理：洛希极限比值等于给定密度项乘属性系数；距离小于该极限则会被撕碎。
local density, type_id, distance = io.read("*l"):match("([%d.]+)%s+(%d+)%s+([%d.]+)")
local limit = tonumber(density) * (type_id == "0" and 2.455 or 1.26)
print(string.format("%.2f %s", limit, tonumber(distance) < limit and "T_T" or "^_^"))
