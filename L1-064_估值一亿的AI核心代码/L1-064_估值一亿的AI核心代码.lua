-- 实现原理：先规范空格和大小写，再依次替换独立短语、独立代词和问号。
local function normalize(line)
    line = line:match("^%s*(.-)%s*$") -- 去除首尾空格
    line = line:gsub("%s+", " ")
    line = line:gsub("%s+([%p])", "%1") -- 标点前不留空格
    line = line:gsub("[A-Z]", function(ch) return ch == "I" and "I" or ch:lower() end)
    line = line:gsub("%f[%a]can%s+you%f[^%a]", "I can")
    line = line:gsub("%f[%a]could%s+you%f[^%a]", "I could")
    line = line:gsub("%f[%a]I%f[^%a]", "you")
    line = line:gsub("%f[%a]me%f[^%a]", "you")
    return line:gsub("%?", "!")
end
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local original = io.read("*l")
    print(original)
    print("AI: " .. normalize(original))
end
