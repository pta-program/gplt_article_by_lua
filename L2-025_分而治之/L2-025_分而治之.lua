-- L2-025 分而治之
-- 实现原理：攻下部分城市后，若任意道路两端仍都未失守，剩余城市就没有
-- 被完全分割。因此每个方案只需检查是否每条道路至少覆盖了一个被攻下端点。

local n, m = io.read("*n"), io.read("*n")
local edges = {}
for i = 1, m do edges[i] = { io.read("*n"), io.read("*n") } end
local k = io.read("*n")
for _ = 1, k do
    local count, taken = io.read("*n"), {}
    for _ = 1, count do taken[io.read("*n")] = true end
    local ok = true
    for _, edge in ipairs(edges) do
        if not taken[edge[1]] and not taken[edge[2]] then ok = false; break end
    end
    print(ok and "YES" or "NO")
end
