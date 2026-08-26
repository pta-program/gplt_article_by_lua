-- 实现原理：按违禁词输入顺序查找未与已选区间重叠的出现位置；计数达阈值时只报警，否则统一替换。
local n=tonumber(io.read("*l")); local words={}; for i=1,n do words[i]=io.read("*l") end; local limit=tonumber(io.read("*l")); local text=io.read("*l"); local marked,count={},0
for _,word in ipairs(words) do local start=1; while true do local p=text:find(word,start,true); if not p then break end; local ok=true; for i=p,p+#word-1 do if marked[i] then ok=false; break end end; if ok then for i=p,p+#word-1 do marked[i]=true end; count=count+1 end; start=p+#word end end
if count>=limit then print(count); print("He Xie Ni Quan Jia!") else local out,i={},1; while i<=#text do if marked[i] then while marked[i] do i=i+1 end; out[#out+1]="<censored>" else out[#out+1]=text:sub(i,i); i=i+1 end end; print(table.concat(out)) end
