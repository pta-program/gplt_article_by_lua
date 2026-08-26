-- 实现原理：大幂数定义为 sum_{i=1}^m i^k == n，从最大幂次向下枚举 k（约1..31），对每个k递增m累加m^k直至≥n，若相等则为解，输出 1^k+...+m^k；最大k优先，突破2^31故上限31
local data = io.read("*a") or ""
local n = tonumber(data:match("-?%d+"))
if not n then return end

local function ipow(a, k, limit)
  local r = 1
  for _ = 1, k do
    r = r * a
    if r > limit then return limit + 1 end
  end
  return r
end

local best_k, best_m = nil, nil
local maxK = 31
-- n < 2^31, 所以k最大31足以
for k = maxK, 1, -1 do
  local sum = 0
  local m = 0
  while sum < n do
    m = m + 1
    local p = ipow(m, k, n - sum)
    -- 防止p溢出超过剩余
    if p > n - sum then
      -- 即使单独超过剩余也意味着sum+p>n，可提前结束本k无解（后续m更大p更大）
      -- 但仍需判断是否恰好溢出边界，直接判定大于n即无解跳出
      break
    end
    sum = sum + p
    if sum == n then
      best_k, best_m = k, m
      break
    end
    -- 防无限：若m过大导致sum远超或增长缓慢，但n<2^31，m上界约65536(k=1)，安全
    if m > 70000 then break end
  end
  if best_k then break end
end

if best_k then
  local parts = {}
  for i = 1, best_m do parts[i] = i .. "^" .. best_k end
  print(table.concat(parts, "+"))
else
  print("Impossible for " .. n .. ".")
end
