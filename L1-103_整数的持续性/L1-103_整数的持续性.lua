-- 实现原理：反复将各位数字相乘直到剩下一位，枚举区间并收集持续性最大的数。
local a,b=io.read("*l"):match("(%d+)%s+(%d+)"); a,b=tonumber(a),tonumber(b)
local function persistence(x) local steps=0; while x>=10 do local p=1; for d in tostring(x):gmatch("%d") do p=p*tonumber(d) end; x=p; steps=steps+1 end; return steps end
local best,answer=-1,{}; for x=a,b do local p=persistence(x); if p>best then best,answer=p,{x} elseif p==best then answer[#answer+1]=x end end; print(best); print(table.concat(answer," "))
