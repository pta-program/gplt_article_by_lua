-- 实现原理：顺序记录点赞者；第 2 位和第 14 位存在时按不同情况拼接固定句式。
local names = {}
while true do
    local name = io.read("*l")
    if name == "." then break end
    names[#names + 1] = name
end
if not names[2] then
    print("Momo... No one is for you ...")
elseif not names[14] then
    print(names[2] .. " is the only one for you...")
else
    print(names[2] .. " and " .. names[14] .. " are inviting you to dinner...")
end
