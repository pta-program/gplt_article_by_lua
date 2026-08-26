-- 实现原理：以试机座位号为键建立哈希表，查询时可 O(1) 找到准考证号和考试座位号。
local n = tonumber(io.read("*l"))
local seats = {}
for _ = 1, n do
    local id, machine, exam = io.read("*l"):match("(%S+)%s+(%d+)%s+(%d+)")
    seats[tonumber(machine)] = { id = id, exam = exam }
end
local m = tonumber(io.read("*l"))
local query = io.read("*l")
local answered = 0
for machine in query:gmatch("%d+") do
    local student = seats[tonumber(machine)]
    print(student.id .. " " .. student.exam)
    answered = answered + 1
    if answered == m then break end
end
