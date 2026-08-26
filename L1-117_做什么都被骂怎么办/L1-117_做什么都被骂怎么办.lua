-- 实现原理：记录中仅出现“被骂(0)”而从未出现“被夸(1)”的编号即为做什么都被骂的人；统计每个编号的 has0/has1，筛选 has0且无has1 的编号升序输出，否则 NONE
local data = io.read("*a") or ""
local toks = {}
for w in data:gmatch("%S+") do toks[#toks+1] = w end
if #toks == 0 then print("NONE"); return end
local n = tonumber(toks[1]) or 0
local info = {} -- id -> {has0, has1}
local idx = 2
for i = 1, n do
  local id = tonumber(toks[idx]); local rec = tonumber(toks[idx+1]); idx = idx + 2
  if id then
    local entry = info[id]
    if not entry then entry = {has0=false, has1=false}; info[id]=entry end
    if rec == 0 then entry.has0 = true
    elseif rec == 1 then entry.has1 = true
    end
  end
end
local ans = {}
for id, e in pairs(info) do
  if e.has0 and not e.has1 then ans[#ans+1] = id end
end
if #ans == 0 then
  print("NONE")
else
  table.sort(ans)
  for i = 1, #ans do
    if i > 1 then io.write(" ") end
    io.write(tostring(ans[i]))
  end
  io.write("\n")
end
