-- 实现原理：按 L1-110 题面（整数序列三操作）实现：1查找替换（首次出现）、2相邻和为偶数插入平均值（同步快照）、3区间翻转；基于 token 流解析以兼容任意换行
local data = io.read("*a") or ""
local toks = {}
for w in data:gmatch("%S+") do toks[#toks+1] = w end
local idx = 1
local function nextTok() local t = toks[idx]; idx = idx + 1; return t end
local function nextInt() local t = nextTok(); return t and tonumber(t) or nil end

if #toks == 0 then return end
local N = nextInt()
local M = nextInt()
if not N or not M then return end
local seq = {}
for i = 1, N do seq[i] = nextInt() end

for _ = 1, M do
  local op = nextInt()
  if not op then break end
  if op == 1 then
    local L1 = nextInt()
    local pat = {}
    for i = 1, (L1 or 0) do pat[i] = nextInt() end
    local L2 = nextInt()
    local rep = {}
    for i = 1, (L2 or 0) do rep[i] = nextInt() end
    -- 查找 pat 在 seq 中的首次出现
    local pos = nil
    if L1 and L1 > 0 and L1 <= #seq then
      for s = 1, #seq - L1 + 1 do
        local ok = true
        for k = 1, L1 do if seq[s+k-1] ~= pat[k] then ok = false; break end end
        if ok then pos = s; break end
      end
    end
    if pos then
      local newSeq = {}
      for i = 1, pos-1 do newSeq[#newSeq+1] = seq[i] end
      for i = 1, #rep do newSeq[#newSeq+1] = rep[i] end
      for i = pos + L1, #seq do newSeq[#newSeq+1] = seq[i] end
      seq = newSeq
    end
  elseif op == 2 then
    if #seq >= 2 then
      local newSeq = {}
      for i = 1, #seq - 1 do
        newSeq[#newSeq+1] = seq[i]
        if ((seq[i] + seq[i+1]) % 2 == 0) then
          newSeq[#newSeq+1] = (seq[i] + seq[i+1]) // 2
        end
      end
      newSeq[#newSeq+1] = seq[#seq]
      seq = newSeq
    end
  elseif op == 3 then
    local l = nextInt()
    local r = nextInt()
    if l and r and l >= 1 and r <= #seq and l <= r then
      while l < r do
        seq[l], seq[r] = seq[r], seq[l]
        l = l + 1; r = r - 1
      end
    end
  end
end

if #seq > 0 then
  for i = 1, #seq do
    if i > 1 then io.write(" ") end
    io.write(tostring(seq[i]))
  end
  io.write("\n")
end
