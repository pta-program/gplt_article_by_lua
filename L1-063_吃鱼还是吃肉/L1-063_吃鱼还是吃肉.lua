-- 实现原理：按性别取得对应的标准身高、体重，依次比较身高和体重给出两条建议。
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local sex, height, weight = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)")
    local standard_h, standard_w = sex == "1" and 130 or 129, sex == "1" and 27 or 25
    height, weight = tonumber(height), tonumber(weight)
    local height_word = height < standard_h and "duo chi yu!" or (height > standard_h and "ni li hai!" or "wan mei!")
    local weight_word = weight < standard_w and "duo chi rou!" or (weight > standard_w and "shao chi rou!" or "wan mei!")
    print(height_word .. " " .. weight_word)
end
