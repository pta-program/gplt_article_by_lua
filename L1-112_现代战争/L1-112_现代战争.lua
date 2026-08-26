-- 实现原理：模拟k次轰炸，每次在未被删除的行列中选全局最大值所在行列删除，最后按原序输出剩余矩阵
local data = io.read("*a") or ""
local toks = {}
for w in data:gmatch("%S+") do toks[#toks+1] = w end
local p = 1
local function nextInt() local v = tonumber(toks[p]); p = p + 1; return v end
if #toks < 3 then return end
local n = nextInt()
local m = nextInt()
local k = nextInt()
if not n or not m or not k then return end
local a = {}
for i = 1, n do
  a[i] = {}
  for j = 1, m do a[i][j] = nextInt() end
end
local rowAlive = {}
for i = 1, n do rowAlive[i] = true end
local colAlive = {}
for j = 1, m do colAlive[j] = true end

for _ = 1, k do
  local maxVal = nil
  local maxR, maxC = nil, nil
  for i = 1, n do
    if rowAlive[i] then
      for j = 1, m do
        if colAlive[j] then
          local v = a[i][j]
          if maxVal == nil or v > maxVal then
            maxVal = v; maxR = i; maxC = j
          end
        end
      end
    end
  end
  if maxR then rowAlive[maxR] = false end
  if maxC then colAlive[maxC] = false end
end

local rows = {}
for i = 1, n do if rowAlive[i] then rows[#rows+1] = i end end
local cols = {}
for j = 1, m do if colAlive[j] then cols[#cols+1] = j end end

for ri, r in ipairs(rows) do
  for ci, c in ipairs(cols) do
    if ci > 1 then io.write(" ") end
    io.write(tostring(a[r][c]))
  end
  if ri < #rows then io.write("\n") end
end
if #rows > 0 then io.write("\n") end
