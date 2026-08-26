-- 实现原理：依次取排名最高的未配对学生，并从末尾找排名最低的异性配对。
local n = tonumber(io.read("*l"))
local students, used = {}, {}
for i = 1, n do
    local gender, name = io.read("*l"):match("(%d)%s+(%S+)")
    students[i] = { gender = gender, name = name }
end
for i = 1, n do
    if not used[i] then
        for j = n, i + 1, -1 do
            if not used[j] and students[i].gender ~= students[j].gender then
                print(students[i].name .. " " .. students[j].name)
                used[i], used[j] = true, true
                break
            end
        end
    end
end
