-- 实现原理：超参数网格搜索，最优为最大得分；查询为大于x的最小得分对应最小编号，二分于去重排序得分
local data = io.read("*a")
if not data then return end
local nums = {}
for s in data:gmatch("-?%d+") do nums[#nums+1]=tonumber(s) end
if #nums == 0 then return end
local p = 1
local n = nums[p]; p=p+1
local scores = {}
for i=1,n do scores[i]=nums[p]; p=p+1 end
-- 若输入不足则直接返回
if n == nil then return end
-- 求最高得分
local maxScore = -1
for i=1,n do if scores[i] > maxScore then maxScore = scores[i] end end
local bestIdx = {}
for i=1,n do if scores[i]==maxScore then bestIdx[#bestIdx+1]=tostring(i) end end
if #bestIdx>0 then print(table.concat(bestIdx," ")) else print("") end
if p > #nums then return end
local m = nums[p]; p=p+1
if m == nil then return end
-- 构建得分->最小编号映射
local scoreToMin = {}
for i=1,n do
    local s = scores[i]
    if scoreToMin[s]==nil or i < scoreToMin[s] then scoreToMin[s]=i end
end
local uniq = {}
for s,_ in pairs(scoreToMin) do uniq[#uniq+1]=s end
table.sort(uniq)
-- 二分查找首个 > x
local function upper_bound(x)
    local l, r = 1, #uniq
    local ans = nil
    while l <= r do
        local mid = math.floor((l+r)/2)
        if uniq[mid] > x then ans = mid; r = mid-1 else l = mid+1 end
    end
    return ans
end
for qi=1,m do
    local x = nums[p]; p=p+1
    if x == nil then print(0)
    else
        local idx = upper_bound(x)
        if idx == nil then print(0)
        else
            local s = uniq[idx]
            print(scoreToMin[s])
        end
    end
end
