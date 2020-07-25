%1
clear
clc
close all
figure
hold on
RT060_SetMotorVoltage(0);

%Pode dar erro a calcular velocidade mas em principio nao
%Pos = zeros(3,1000);   
%Time = zeros(3,1000);
%Velocity = zeros(3,1000);

for j=1:1:3
    i = 1;
    RT060_GotoPosition(0);                      %Vai para o 0
    
    timerVal = tic;                             %Começa timer
    Time(j,i) = toc(timerVal);                  %Guarda o tempo em (1,1);(2,1);(3,1)
    
    RT060_SetMotorVoltage(3);                   %Aplica tensão
    
    Pos(j,i) = RT060_GetPosition();             %Guarda a posicao em (1,1);(2,1);(3,1)
    Velocity(j,i) = Pos(j,1:i)/Time(j,1:i);     %Guarda a velocidade em (1,1);(2,1);(3,1)
    
    while Time(i) < 3                           %Enquanto Timer < 3s
        i = i + 1;                              %Passa para i = 2
        Pos(j,i) = RT060_GetPosition();         %Guarda Posição em (1,i);(2,i);(3,i)
        Time(j,i) = toc(timerVal);              %Guarda Tempo em (1,i);(2,i);(3,i)
        Velocity(j,i) = Pos(j,1:i)/Time(j,1:i); %Guarda Velocidade em (1,i);(2,i);(3,i)
    end
    
    RT060_SetMotorVoltage(0);                   %Aplica V=0
    
    %idx_Pos = find(Pos);
    idx_Time = find(Time);
    idx_Velocity = find(Velocity);
    plot(Time(idx_Time),Pos(idx_Pos));          %Gráfico Pos/Time
end
legend('Tentativa 1','Tentativa 2','Tentativa 3')
xlabel(Time)
title('Velocity');