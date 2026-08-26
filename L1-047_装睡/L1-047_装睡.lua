-- 实现原理：呼吸次数须在 [15,20]、脉搏须在 [50,70]；任一越界就输出该姓名。
local n = tonumber(io.read("*l"))
for _ = 1, n do
    local name, breath, pulse = io.read("*l"):match("(%S+)%s+(%d+)%s+(%d+)")
    breath, pulse = tonumber(breath), tonumber(pulse)
    if breath < 15 or breath > 20 or pulse < 50 or pulse > 70 then print(name) end
end
