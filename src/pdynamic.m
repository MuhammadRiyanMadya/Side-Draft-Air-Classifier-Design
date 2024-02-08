function motion = pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun)
%%-----------------PERSAMAAN DINAMIKA PARTIKEL----------------%%
y = mot(1) ;
vy = mot(2) ;
x = mot(3) ;
vx = mot(4) ;
Rey = rhon*vy*dp/miun ;
Rex = rhon*(vu-vx)*dp/miun ;
if Rex < 0.1
CDx = 24/Rex;
else
CDx = (24/Rex)*(1+0.14*Rex^0.70);
end
if Rey < 0.1
CDy = 24/Rey;
else
CDy = (24/Rey)*(1+0.14*Rey^0.70);
end
Fd = ((3*rhon)/(2*dp*rhop))*CDx*(vu-vx)^2 ;
Fc = ((vr*2*pi*r/60)^2)/r ;
motion = [vy ; (g -((3*rhon)/(2*dp*rhop))*CDy*vy^2) ; vx ; (Fd-Fc)] ;
end