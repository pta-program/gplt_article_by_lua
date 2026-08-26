-- 实现原理：有向概率图贪心推理，visited去重，每步选未访问后继中概率最大、并列编号最小，直至无出边
local data = io.read("*a")
if not data then return end
local nums = {}
for s in data:gmatch("-?%d+") do nums[#nums+1]=tonumber(s) end
if #nums < 2 then return end
local n = nums[1]; local m = nums[2]
local idx = 3
local adj = {}
for i=1,n do adj[i]={} end
for i=1,m do
    local a = nums[idx]; local b = nums[idx+1]; local p = nums[idx+2]; idx=idx+3
    if a and b and p then
        if a>=1 and a<=n and b>=1 and b<=n then
            adj[a][#adj[a]+1]={to=b, w=p}
        end
    end
end
if idx > #nums then return end
local K = nums[idx]; idx=idx+1
if K==nil then return end
local queries = {}
for i=1,K do queries[i]=nums[idx]; idx=idx+1 end
for qi=1,K do
    local start = queries[qi]
    if not start or start<1 or start>n then
        print("")
    else
        local visited = {}
        for i=1,n do visited[i]=false end
        local path = {start}
        visited[start]=true
        local cur = start
        while true do
            local best = nil
            local bestW = -1
            local bestTo = nil
            for _, e in ipairs(adj[cur]) do
                if not visited[e.to] then
                    if e.w > bestW or (e.w==bestW and e.to < bestTo) then
                        bestW = e.w; bestTo = e.to; best = e
                    end
                end
            end
            if not best then break end
            cur = bestTo
            visited[cur]=true
            path[#path+1]=cur
        end
        local out={}
        for _,v in ipairs(path) do out[#out+1]=tostring(v) end
        print(table.concat(out,"->"))
    end
end
