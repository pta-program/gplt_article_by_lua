-- 实现原理：将字符串每个字母映射为给定的 26 个权值，并输出映射序列及权值和。
local text=io.read("*l"); local values={}; for x in io.read("*l"):gmatch("-?%d+") do values[#values+1]=tonumber(x) end; local out,sum={},0; for ch in text:gmatch(".") do local v=values[string.byte(ch)-string.byte("a")+1]; out[#out+1]=v; sum=sum+v end; print(table.concat(out," ")); print(sum)
