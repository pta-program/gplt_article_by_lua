-- 实现原理：枚举每个中心并向两侧扩展，分别处理奇数和偶数长度回文。
local s=io.read("*l"); local best=1; for c=1,#s do local l,r=c,c; while l>=1 and r<=#s and s:sub(l,l)==s:sub(r,r) do best=math.max(best,r-l+1); l,r=l-1,r+1 end; l,r=c,c+1; while l>=1 and r<=#s and s:sub(l,l)==s:sub(r,r) do best=math.max(best,r-l+1); l,r=l-1,r+1 end end; print(best)
