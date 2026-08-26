-- 实现原理：含小写 qiandao 或 easy 的题跳过，其余题依次计数，取完成 M 题后的下一题。
local n, m = io.read("*l"):match("(%d+)%s+(%d+)")
n, m = tonumber(n), tonumber(m)
local solved, answer = 0, nil
for _ = 1, n do
    local problem = io.read("*l")
    if not problem:find("qiandao", 1, true) and not problem:find("easy", 1, true) then
        if solved == m and not answer then answer = problem end
        solved = solved + 1
    end
end
print(answer or "Wo AK le")
