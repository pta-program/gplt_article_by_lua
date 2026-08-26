-- 实现原理：逐行计数并用普通子串搜索关键词，同时记录首次出现位置与总次数。
local total, first, count = 0, nil, 0
while true do
    local line = io.read("*l")
    if line == "." then break end
    total = total + 1
    if line:find("chi1 huo3 guo1", 1, true) then
        count = count + 1
        if not first then first = total end
    end
end
print(total)
if first then print(first .. " " .. count) else print("-_-#") end
