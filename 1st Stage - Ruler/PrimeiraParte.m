%1
%1.2
clear
clc
figure
RT060_GotoPosition(10);

[M100,T100] = RT060_GotoPosition_V2(100);  %100
[M50,T50] = RT060_GotoPosition_V2(50);    %50
[M200,T200] = RT060_GotoPosition_V2(200);  %200
[M150,T150] = RT060_GotoPosition_V2(150);  %150

Measure = vertcat(M100,M50,M200,M150);
T50 = T50+T100(end);
T200 = T200+T50(end);
T150 = T150 + T200(end);
Time = vertcat(T100,T50,T200,T150);
hold on
plot(Time,Measure)
title('Posição em função do tempo')
grid on
xlabel('Tempo (s)')
ylabel('Posição (mm)')