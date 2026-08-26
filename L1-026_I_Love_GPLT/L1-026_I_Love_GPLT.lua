-- 实现原理：逐字符输出固定字符串，空格也作为独立的一行保留。
for ch in ("I Love GPLT"):gmatch(".") do print(ch) end
