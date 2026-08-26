-- 实现原理：把 y 看作二进制 0、n 看作二进制 1；路径对应的值加 1 即叶子从左到右的编号。
local _, m = io.read("*l"):match("(%d+)%s+(%d+)")
for _ = 1, tonumber(m) do
    local value = 0
    for ch in io.read("*l"):gmatch(".") do value = value * 2 + (ch == "n" and 1 or 0) end
    print(value + 1)
end
