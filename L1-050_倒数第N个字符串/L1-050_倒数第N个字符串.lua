-- 实现原理：倒数第 N 个等于从 0 开始的 26 进制编号 26^L-N，将每位映射为 a 到 z。
local length, n = io.read("*l"):match("(%d+)%s+(%d+)")
length, n = tonumber(length), tonumber(n)
local value = 26 ^ length - n
local chars = {}
for i = length, 1, -1 do
    chars[i] = string.char(string.byte("a") + value % 26)
    value = value // 26
end
print(table.concat(chars))
