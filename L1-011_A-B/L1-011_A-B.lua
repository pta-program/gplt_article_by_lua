-- 实现原理：把字符串 B 中出现过的字符标记到集合中，再过滤字符串 A。
local a = io.read("*l")
local b = io.read("*l")
local forbidden, answer = {}, {}
for i = 1, #b do forbidden[b:sub(i, i)] = true end
for i = 1, #a do
    local ch = a:sub(i, i)
    if not forbidden[ch] then answer[#answer + 1] = ch end
end
print(table.concat(answer))
