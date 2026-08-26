-- 实现原理：DFS构造多项式整除数(前i位能被i整除)，区间[a,b]过滤输出；余数剪枝保证首位非0
local data = io.read("*a")
if not data or data:match("^%s*$") then return end
local nums = {}
for s in data:gmatch("-?%d+") do nums[#nums+1] = tonumber(s) end
if #nums == 0 then return end
local n, a, b
if #nums >= 3 then
    n = nums[1]; a = nums[2]; b = nums[3]
elseif #nums == 2 then
    n = nums[1]; a = 10^(n-1); b = nums[2]
else
    n = nums[1]; a = 10^(n-1); b = 10^n - 1
end
if n == nil then return end
-- 若 a > b 交换
if a and b and a > b then a, b = b, a end
-- 若区间明显超出n位数范围则裁剪
local low = 10^(n-1)
local high = 10^n - 1
if a < low then a = low end
if b > high then b = high end
if a > b then print("No Solution"); return end
local results = {}
local function dfs(prefix, len)
    if len == n then
        if prefix >= a and prefix <= b then
            results[#results+1] = prefix
        end
        return
    end
    -- 剪枝：剩余位最小最大值区间
    local rem = n - len - 1
    -- 粗略剪枝，若当前前缀*10^{rem} > b 或 (prefix+1)*10^{rem} < a 可跳过，但为保证正确性不强剪
    for d = 0, 9 do
        local nxt = prefix * 10 + d
        if nxt % (len + 1) == 0 then
            -- 进一步区间剪枝
            if rem >= 0 then
                local minPossible = nxt * (10 ^ rem)
                local maxPossible = (nxt + 1) * (10 ^ rem) - 1
                if maxPossible < a or minPossible > b then
                    -- 跳过该分支
                else
                    dfs(nxt, len + 1)
                end
            else
                dfs(nxt, len + 1)
            end
        end
    end
end
for d = 1, 9 do
    if d % 1 == 0 then
        -- 首位长度1必整除1
        if d >= a or true then
            -- 若 n==1 特殊
            if n == 1 then
                if d >= a and d <= b then results[#results+1]=d end
            else
                dfs(d, 1)
            end
        end
    end
end
table.sort(results)
if #results == 0 then
    print("No Solution")
else
    for _, v in ipairs(results) do print(v) end
end
