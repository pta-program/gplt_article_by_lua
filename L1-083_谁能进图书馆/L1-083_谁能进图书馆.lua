-- 实现原理：成年人可独立入馆；未达门槛的儿童仅在另一人达到陪同年龄时可进入。
local minimum, adult, age1, age2 = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
minimum, adult, age1, age2 = tonumber(minimum), tonumber(adult), tonumber(age1), tonumber(age2)
local in1 = age1 >= minimum or (age1 < minimum and age2 >= adult)
local in2 = age2 >= minimum or (age2 < minimum and age1 >= adult)
print(age1 .. (in1 and "-Y" or "-N") .. " " .. age2 .. (in2 and "-Y" or "-N"))
if in1 and in2 then
    if age1 < minimum then print("qing 2 zhao gu hao 1")
    elseif age2 < minimum then print("qing 1 zhao gu hao 2")
    else print("huan ying ru guan") end
elseif not in1 and not in2 then
    print("zhang da zai lai ba")
else
    print((in1 and 1 or 2) .. ": huan ying ru guan")
end
