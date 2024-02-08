%%-----PROGRAM DINAMIKA PARTIKEL DI DALAM SIDE DRAFT AIR CLASSIFIER---%%
%%--Last Edited: 13 July 2022
clc;
clear;
%%---Data Perancangan Side-Draft Air Classifier---%%
rhop = 474 ; %kg/m^3 : Densitas polimer
g = 9.8 ; %m/s^2 : Percepatan gravitas
r = 0.25 ; %m : Jar-jari rotor
miun = 0.00001744 ; %Pa.s : Viskositas nitrogen
rhon = 1.16 ; %Kg/m^3 : Densitas nitrogen
v0 = 0.1 ; % m/s : Kecepatan awal ke bawah
vr = 120; % rpm : Kecepatan putaran rotor
vu = 2; % m/s : Kecepetan nitrogen masuk
tspan = 0:0.1:2;
%-----------------------SOLVER DIFFERENSIAL EQ-----------------------%
y0 = 0 +eps ;
vx0 = v0 +eps;
x0 = 0 +eps;
vy0 = 0 +eps;
for dp = 0.00236
[t,mot1] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.00200
[t,mot2] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.0014
[t,mot3] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.00085
[t,mot4] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.000425
[t,mot5] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.000250
[t,mot6] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.00015
[t,mot7] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
for dp = 0.000075
[t,mot8] = ode45(@(t,mot)pdynamic(t,mot,dp,g,vr,r,vu,rhon,rhop,miun),...
tspan, [y0;vy0;x0;vx0]);
end
%%----------------------GRAPHICAL INTERPRETATION--------------------%%
tiledlayout(3,3)
set (gcf,'Position',[0,0.1,1300,800])
nexttile
plot(t,mot1( : , 1),'bo',t,mot1(: , 3),'ko',t,mot2( : , 1),'bx',t,mot2( : , 3),'kx'...
,t,mot3( : , 1),'b+',t,mot3(: , 3),'k+',t,mot4( : , 1),'b*',t,mot4( : , 3),'k*'...
,t,mot5( : , 1),'bs',t,mot5(: , 3),'ks',t,mot6( : , 1),'bd',t,mot6( : , 3),'kd'...
,t,mot7( : , 1),'bv',t,mot7(: , 3),'kv',t,mot8( : , 1),'bh',t,mot8( : , 3),'kh')
grid on
xlabel('Waktu, detik');
ylabel('Perpindahan, meter');
leg=legend('dp 2360','dp 2360','dp 2000','dp 2000','dp 1400','dp 1400'...
,'dp 850','dp 850','dp 425','dp 425','dp 250','dp 250'...
,'dp 150','dp 150','dp 75','dp 75','location','eastoutside') ;
leg.ItemTokenSize=[2,2];
title('Perpindahan Partikel di Sb. X dan Sb. Y');
nexttile
plot(t,mot1( : , 2 ),'bo',t,mot1( : , 4),'ko',t,mot5( : , 2 ),'bs',t,mot5( : , 4),...
'ks',t,mot8( : , 2 ),'bh',t,mot8( : , 4),'kh','LineWidth',2)
grid on
xlabel('Waktu, detik');
ylabel('Kecepatan, meter/detik');
leg=legend('vy 2360','vx 2360','vy 425','vx 425','vy 75','vx 75','location'...
,'eastoutside') ;
leg.ItemTokenSize=[10,10];
title('Kecepatan Partikel di Sb. X dan Sb. Y');
rangedim=[0.00236, 0.002,0.0014,0.00085,0.000425,0.000250,0.00015,0.000075]';
x1det = [mot1(11,3), mot2(11,3),mot3(11,3),mot4(11,3),mot5(11,3),mot6(11,3),...
mot7(11,3),mot8(11,3)]';
y1det = [mot1(11,1), mot2(11,1),mot3(11,1),mot4(11,1),mot5(11,1),mot6(11,1),...
mot7(11,1),mot8(11,1)]';
nexttile
plot(rangedim, x1det);
hold on
plot(rangedim, y1det);
xlabel('Diameter, m')
ylabel('Perpindahan, m')
title('Diameter Partikel vs Pergerakan Horizontal')
celah = 0.15 + r/2; %m
dpcutsize=interp1(x1det,rangedim,celah);
hT = interp1(rangedim,y1det,dpcutsize);
hold on
%------Jika Tinggi Separation Zone sudah FIX-----------%
z1det=zeros(length(x1det),1);
for i = 1:length(x1det)
if x1det(i) >= 0
z1det(i) = sqrt(x1det(i).^2+y1det(i).^2);
else
z1det(i) = -sqrt(x1det(i).^2+y1det(i).^2);
end
end
z1dethasil = z1det(:,:);
zfix = sqrt(0.6566^2+celah^2);
dpcutsizenew = interp1(z1dethasil,rangedim,zfix);
nexttile
rangedim2=[0.00236, 0.002,0.0014,0.00085,0.000425,0.000250,0.00015,0.000075]';
PSD = [100,98.529,95.211,93.169,33.473,5.513,1.219,0.207]';
intv = 0:0.000001:0.00236;
PSDa = interp1(rangedim2,PSD,intv,'spline');
plot(rangedim2,PSD,'o',intv,PSDa)
ylim([0 100])
hold on
cuts=interp1(rangedim2,PSD,dpcutsize);
cutnew=interp1(rangedim2,PSD,dpcutsizenew);
cp = 18.0;
c = (cuts/100)*cp;
f = cp-c ;
hold on
yline(cuts,'k--')
xline(dpcutsize,'k--')
xlabel('dp, meter')
ylabel('% Kumulasi')
title('Data Kumulasi PSD')
nexttile
plot(rangedim2,PSD,'o',intv,PSDa,'k-',dpcutsizenew,cutnew,'bo')
hold on
yline(cuts,'k--')
xline(dpcutsize,'k--')
xlabel('dp, meter')
ylabel('% Kumulasi')
title('Data Kumulasi PSD')

fprintf('Tabel Summary Perancangan SD Air Classifier\n')
fprintf('-------------------------------------------------\n')
fprintf(['|Tinggi rotor \t\t: %6.4f m\t|\n|Celah Rotor \t\t: %6.4f m\t|\n' ...
'|Dp Cut Size \t\t: %6.8f m\t|\n' ...
'|Fraksi Fine \t\t: %6.4f \t|\n' ...
'\n'],[hT;celah;dpcutsize;...
;cuts/100;])
