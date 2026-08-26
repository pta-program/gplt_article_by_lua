-- 实现原理：按输入顺序计数，找到首个值为 250 的位置即输出。
local index = 0
for token in io.read("*l"):gmatch("-?%d+") do
    index = index + 1
    if tonumber(token) == 250 then print(index); break end
end
