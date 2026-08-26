-- L3-034 超能力者大赛
-- 实现原理：Floyd 预处理城市距离；每天按“可击败、能力最接近、距离最短、
-- 城市编号最小”的优先级选择目标，移动后战斗并把对手能力并入自身。
local N,M,E,D=io.read('*n','*n','*n','*n');local city,pow,alive={}, {},{}
for i=0,N-1 do city[i],pow[i]=io.read('*n','*n');alive[i]=true end
local inf=1e18;local dis={}
for i=0,M-1 do dis[i]={};for j=0,M-1 do dis[i][j]=(i==j and 0 or inf) end end
for _=1,E do local a,b,w=io.read('*n','*n','*n');dis[a][b]=w;dis[b][a]=w end
for k=0,M-1 do for i=0,M-1 do for j=0,M-1 do if dis[i][k]+dis[k][j]<dis[i][j] then dis[i][j]=dis[i][k]+dis[k][j] end end end end
local me,where,day=pow[0],city[0],0
while day<D do
 local who=nil
 for i=1,N-1 do if alive[i] and pow[i]<=me and (not who or pow[i]>pow[who] or (pow[i]==pow[who] and (dis[where][city[i]]<dis[where][city[who]] or (dis[where][city[i]]==dis[where][city[who]] and city[i]<city[who])))) then who=i end end
 if not who then print('Lose on day '..(day+1)..' with '..me..'.');break end
 if city[who]~=where then print('Move from '..where..' to '..city[who]..'.');day=day+dis[where][city[who]];where=city[who] end
 day=day+1;if day>D then print('Game over with '..me..'.');break end
 print('Get '..pow[who]..' at '..where..' on day '..day..'.');me=me+pow[who];alive[who]=false
 local left=false;for i=1,N-1 do if alive[i] then left=true end end;if not left then print('WIN on day '..day..' with '..me..'!');break end
end
