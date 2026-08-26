-- 实现原理：操作1查找允许重叠的前3次出现位置(0-indexed)，操作2在p前插入s2首字符，操作3翻转闭区间[l,r]；均0-indexed，修复原语法错误 local ans={},start=1 -> local ans, start = {}, 1
local data = io.read("*a") or ""
-- 按空白分割为 tokens，首个为 N，第二个为初始串 S，之后为操作序列
local toks = {}
for w in data:gmatch("%S+") do toks[#toks+1] = w end
if #toks == 0 then return end
local pos = 1
local N = tonumber(toks[pos]); pos = pos + 1
local text = toks[pos] or ""; pos = pos + 1
-- 兼容初始串为空的极端情况
if N == nil then return end
-- 若初始串包含空白（题面保证不含），token方式已足够
for _ = 1, N do
  local op = tonumber(toks[pos]); pos = pos + 1
  if not op then break end
  if op == 1 then
    local word = toks[pos] or ""; pos = pos + 1
    local ans, start = {}, 1
    while true do
      local p = text:find(word, start, true)
      if not p then break end
      ans[#ans+1] = p - 1
      if #ans >= 3 then break end
      start = p + 1
    end
    if #ans == 0 then print(-1) else print(table.concat(ans, " ")) end
  elseif op == 2 then
    local p = tonumber(toks[pos]); pos = pos + 1
    local s2 = toks[pos] or ""; pos = pos + 1
    local ch = s2:sub(1,1)
    -- p 为0-indexed插入位置：插入到下标为p的字符之前，p==|T|为末尾
    if p < 0 then p = 0 end
    if p > #text then p = #text end
    text = text:sub(1, p) .. ch .. text:sub(p + 1)
    print(text)
  elseif op == 3 then
    local l = tonumber(toks[pos]); pos = pos + 1
    local r = tonumber(toks[pos]); pos = pos + 1
    if l and r and l <= r and l >= 0 and r < #text then
      -- 0-indexed [l,r] 转 Lua 1-indexed: sub(l+1, r+1)
      local mid = text:sub(l + 1, r + 1):reverse()
      text = text:sub(1, l) .. mid .. text:sub(r + 2)
    end
    print(text)
  end
end
