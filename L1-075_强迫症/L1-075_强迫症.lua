-- 实现原理：四位输入的前两位为年份后缀；小于 22 归入 2000 年代，否则归入 1900 年代。
local text = io.read("*l")
if #text == 6 then
    print(text:sub(1, 4) .. "-" .. text:sub(5, 6))
else
    local yy = tonumber(text:sub(1, 2))
    print((yy < 22 and "20" or "19") .. text:sub(1, 2) .. "-" .. text:sub(3, 4))
end
