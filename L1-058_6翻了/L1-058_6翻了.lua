-- 实现原理：用模式匹配连续的 6；长度大于 9 替换为 27，长度大于 3 替换为 9。
local sentence = io.read("*l")
sentence = sentence:gsub("6+", function(run)
    if #run > 9 then return "27" end
    if #run > 3 then return "9" end
    return run
end)
print(sentence)
