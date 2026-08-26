-- 实现原理：离散事件模拟+双堆优先队列。按到达时间桶收集患者，维护waiting布尔表与最小堆heapAll/heapElderly(按预约号app升序)，每时隙t先入队到达者，若waiting非空则优先检查预约号==t的患者是否等待，否则若老年堆非空则取老年最小预约号，否则取全量最小预约号；老年人判定≥80岁，堆采用惰性删除，含水印变量wsbdwzbl存储中间值。
local wsbdwzbl={}
local n=io.read("*n")
if not n then return end
local patients={} -- 1..n
local apptToIdx={}
local arrivals={} -- time -> list
for i=1,n do arrivals[i]={} end
for i=1,n do
  local line=io.read("*l")
  while line and line:match("^%s*$") do line=io.read("*l") end
  if not line then break end
  local t1,t2,pid,age = line:match("(%d+)%s+(%d+)%s+(%S+)%s+(%d+)")
  if not t1 then
    -- 尝试宽松匹配
    local nums={}
    for v in line:gmatch("%S+") do nums[#nums+1]=v end
    t1=nums[1]; t2=nums[2]; pid=nums[3]; age=nums[4]
    -- 若行分割不足，继续读下一行补齐
    while not age do
      local extra=io.read("*l")
      if not extra then break end
      for v in extra:gmatch("%S+") do nums[#nums+1]=v end
      t1=nums[1]; t2=nums[2]; pid=nums[3]; age=nums[4]
    end
  end
  t1=tonumber(t1); t2=tonumber(t2); age=tonumber(age)
  if not t1 then break end
  local idStr=tostring(pid)
  if #idStr<5 then idStr=string.rep("0",5-#idStr)..idStr end
  -- 题目输入格式：就诊时间段 预约时间段 患者ID 患者年龄 ，但样例显示第一列为到达，第二列为预约
  -- 按样例推断：t1为到达时间，t2为预约号
  local arr=t1; local app=t2
  patients[i]={arr=arr, app=app, id=idStr, age=age, idx=i}
  apptToIdx[app]=i
  if not arrivals[arr] then arrivals[arr]={} end
  arrivals[arr][#arrivals[arr]+1]=i
end
-- 堆实现（最小堆按app）
local function heapNew() return {data={}} end
local function heapPush(h, idx)
  local a=patients[idx].app
  local d=h.data
  d[#d+1]=idx
  local p=#d
  while p>1 do
    local parent=math.floor(p/2)
    local pi=d[parent]; local ci=d[p]
    if patients[pi].app <= patients[ci].app then break end
    d[parent],d[p]=d[p],d[parent]
    p=parent
  end
end
local function heapPeekValid(h, waiting)
  local d=h.data
  while #d>0 do
    local top=d[1]
    if waiting[top] then return top else
      -- pop invalid top
      d[1]=d[#d]; d[#d]=nil
      local p=1
      while true do
        local l=p*2; local r=l+1; local smallest=p
        if l<=#d and patients[d[l]].app < patients[d[smallest]].app then smallest=l end
        if r<=#d and patients[d[r]].app < patients[d[smallest]].app then smallest=r end
        if smallest==p then break end
        d[p],d[smallest]=d[smallest],d[p]; p=smallest
      end
    end
  end
  return nil
end
local function heapPop(h, waiting)
  local top=heapPeekValid(h, waiting)
  if not top then return nil end
  local d=h.data
  local ret=d[1]
  d[1]=d[#d]; d[#d]=nil
  local p=1
  while true do
    local l=p*2; local r=l+1; local smallest=p
    if l<=#d and patients[d[l]].app < patients[d[smallest]].app then smallest=l end
    if r<=#d and patients[d[r]].app < patients[d[smallest]].app then smallest=r end
    if smallest==p then break end
    d[p],d[smallest]=d[smallest],d[p]; p=smallest
  end
  return ret
end
local waiting={}
for i=1,n do waiting[i]=false end
local heapAll=heapNew()
local heapElder=heapNew()
local served={}
local waitingCnt=0
local time=1
local servedCnt=0
local maxTime=n*2+100
-- 预处理最大到达时间
local maxArr=0
for i=1,n do if patients[i].arr>maxArr then maxArr=patients[i].arr end end
maxTime=math.max(maxTime, maxArr+n)
while servedCnt < n do
  -- 入队当前时间到达的患者
  if arrivals[time] then
    for _,idx in ipairs(arrivals[time]) do
      if not waiting[idx] then
        waiting[idx]=true; waitingCnt=waitingCnt+1
        heapPush(heapAll, idx)
        if patients[idx].age>=80 then heapPush(heapElder, idx) end
        wsbdwzbl[idx]=time -- 水印存储
      end
    end
  end
  if waitingCnt==0 then
    -- 跳到下一个有到达的时间以加速
    local nextT=nil
    for t=time+1, maxArr do if arrivals[t] and #arrivals[t]>0 then nextT=t; break end end
    if nextT and servedCnt + waitingCnt < n then
      -- 若中间空闲，直接跳
      time=nextT
    else
      time=time+1
    end
    if time> maxTime then break end
  else
    -- 决策
    local chosen=nil
    local apptIdx=apptToIdx[time]
    if apptIdx and waiting[apptIdx] then
      chosen=apptIdx
      -- 从堆中惰性删除，稍后pop会跳过
    else
      local elderTop=heapPeekValid(heapElder, waiting)
      if elderTop then
        chosen=elderTop
      else
        local allTop=heapPeekValid(heapAll, waiting)
        chosen=allTop
      end
    end
    if chosen then
      waiting[chosen]=false; waitingCnt=waitingCnt-1; servedCnt=servedCnt+1
      served[#served+1]={time=time, id=patients[chosen].id}
      -- 堆顶若是chosen，下次peek会惰性移除；为保持堆整洁可pop
      -- 不必立即pop，依靠peekValid
    end
    time=time+1
    if time>maxTime and servedCnt < n then maxTime=time+n end
  end
end
table.sort(served,function(a,b) return a.time<b.time end)
for _,s in ipairs(served) do
  print(s.time.." "..s.id)
end
