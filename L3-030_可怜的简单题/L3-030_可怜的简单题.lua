-- L3-030 可怜的简单题
--
-- 实现原理：E[T]=1+sum_{k>=1}P(gcd(A_1..A_k)>1)。由 Möbius 反演，
-- P(gcd>1)=sum_{d>=2}-mu[d]*(floor(n/d)/n)^k；对几何级数求和即可得到
-- 1+sum_{d>=2}-mu[d]*q/(n-q)，其中 q=floor(n/d)。

local n,p=io.read('*n','*n')
local function mul(a,b) -- 避免 p 可达 1e12 时的整数乘法溢出
 local r=0;a=a%p
 while b>0 do if b%2==1 then r=(r+a)%p end;a=(a*2)%p;b=b//2 end
 return r
end
local function power(a,e)
 local r=1
 while e>0 do if e%2==1 then r=mul(r,a) end;a=mul(a,a);e=e//2 end
 return r
end
local mu={};local prime={},{};mu[1]=1
for i=2,n do
 if not prime[i] then prime[#prime+1]=i;mu[i]=-1 end
 for _,v in ipairs(prime) do
  if i*v>n then break end
  if i%v==0 then mu[i*v]=0;break else mu[i*v]=-mu[i] end
 end
end
local ans=1%p
for d=2,n do
 if mu[d] and mu[d]~=0 then
  local q=n//d;local term=mul(q%p,power((n-q)%p,p-2))
  if mu[d]==1 then ans=(ans-term)%p else ans=(ans+term)%p end
 end
end
print((ans+p)%p)
