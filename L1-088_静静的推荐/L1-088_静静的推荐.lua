-- 实现原理：同分数普通学生每批至多推荐一人；PAT 达线者可额外推荐，按分数独立累计。
local n, k, threshold = io.read("*l"):match("(%d+)%s+(%d+)%s+(%d+)")
n, k, threshold = tonumber(n), tonumber(k), tonumber(threshold)
local total, qualified = {}, {}
for _ = 1, n do
    local score, pat = io.read("*l"):match("(%d+)%s+(%d+)")
    score, pat = tonumber(score), tonumber(pat)
    if score >= 175 then
        total[score] = (total[score] or 0) + 1
        if pat >= threshold then qualified[score] = (qualified[score] or 0) + 1 end
    end
end
local answer = 0
for score, count in pairs(total) do
    local special = qualified[score] or 0
    answer = answer + special + math.min(k, count - special)
end
print(answer)
