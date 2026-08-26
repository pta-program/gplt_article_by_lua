-- 实现原理：将整数作为字符串处理，负号单独映射为 fu，其余字符查表转换为拼音。
local names = { ["0"] = "ling", ["1"] = "yi", ["2"] = "er", ["3"] = "san", ["4"] = "si",
                ["5"] = "wu", ["6"] = "liu", ["7"] = "qi", ["8"] = "ba", ["9"] = "jiu" }
local s = io.read("*l")
local result = {}
if s:sub(1, 1) == "-" then
    result[#result + 1] = "fu"
    s = s:sub(2)
end
for i = 1, #s do result[#result + 1] = names[s:sub(i, i)] end
print(table.concat(result, " "))
