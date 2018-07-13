clc;
clear all;
close all
%%Problema_3
%% vetor a em latitude, longitude e altitude geodesica
% a =  2°20'17.4"S  44°25'01.7"W  0
% lat = [2 20 17.4];
% lon = [44 25 1.7];
lat = [2 20 17.4];
lon = [44 25 1.7];

% geodesica
[lat,lon] = ll2rad(lat,'S',lon,'W');

% semieixo maior WGS 84
wgs84 = wgs84Ellipsoid;
a = wgs84.SemimajorAxis;
b = wgs84.SemiminorAxis;
% achatamento
f = 1 - b/a;
% excentricidade
e = sqrt(f*(2-f));

% conversao para o sistema centrado na terra
N = a/sqrt(1-e^2*sin(lat)^2);
x = N*cos(lat)*cos(lon);
y = N*cos(lat)*sin(lon);
z = N*(1-e^2)*sin(lat);


%% vetor em coordenadas terrestres
a_T = [x y z]';
a_T = a_T/norm(a_T)


%% data
data_ut.ano = 2018;
data_ut.mes = 06;
data_ut.dia = 29;
data_ut.h = 21;
data_ut.m = 35;
data_ut.s = 50;
   
% data juliana contada a partir do meio dia sem fracao de dia
[DJ0, DJ] = date2JD(data_ut);

% seculos julianos
T_0 = (DJ0-2451545.5)/36525;
% tempo sideral de Greenwich
t_g0 = 100.4606184 + 36000.77004*T_0 + 0.000387933*T_0^2 - 2.583e-8*T_0^3;
t_g0 = mod(t_g0, 360);
% hora ut de interesse em fracao de dia
UT = data_ut.h + data_ut.m/60 + data_ut.s/3600;
% tempo sideral de greenwich
t_g = t_g0 + 360.98564724*UT/24;
t_g = mod(t_g,360);

% tempo sideral local
t_g_local = tgLocal(t_g, lon, 'W');

% rotacao de um angulo tg que leva o sistema terrestre para o sgi
tg = deg2rad(t_g);
R_TI = [cos(tg) -sin(tg) 0;
        sin(tg) cos(tg) 0;
        0 0 1];
a_I = R_TI*a_T
