clc;
close all;
clear;
ks= [0.02:0.01:0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95 1 2];
pos=zeros(500,1);
velocity=zeros(500,1);
V=zeros(500,1);

for k = 1:length(ks)
    j=2;
    RT060_GotoPosition(0);
    i=1;
    erro=120;
    timer2=tic;
    Time2(i)=toc(timer2);
    while Time2(i) < 20
        timer1=tic;
        Time1(i)=toc(timer1);
        erro=120-pos(j-1)
        V(j)=erro*ks(k);
        RT060_SetMotorVoltage(V(j));
        while Time1(i) < 0.1
            pos(j) = RT060_GetPosition();
            Time1(i)=toc(timer1);
        end
        i=i+1;
        Time2(i)=toc(timer2);
        j=j+1;
    end
    pos=pos(find(pos));
    data(1:length(pos),k,1)=pos;
    velocity = (pos(2:end)-pos(1:end-1))/0.1;
    data(1:length(velocity),k,2)=velocity;
    data(1:length(V),k,3)=V;
end
RT060_GotoPosition(0);

%1ºs Gráficos de Posição
figure
hold on
for i = 1:9
    idx_Pos = find(data(:,i,1));
    plot(0.1*idx_Pos(1:0.75*idx_Pos(end)),data(idx_Pos(1:0.75*idx_Pos(end)),i,1))    
end
legend('K = 0.02','K = 0.03','K = 0.04','K = 0.05','K = 0.06','K = 0.07','K = 0.08','K = 0.09','K = 0.1')
title('Regime Sub-Amortecido');
ylabel('Posição (mm)')
xlabel('Tempo (s)')

%2ºs Gráficos de Posição
figure
hold on
for i = 10:17
    idx_Pos = find(data(:,i,1));
    plot(0.1*idx_Pos(1:0.2*idx_Pos(end)),data(idx_Pos(1:0.2*idx_Pos(end)),i,1))    
end
legend('K = 0.2','K = 0.3','K = 0.4','K = 0.5','K = 0.6','K = 0.7','K = 0.8','K = 0.9')
title('Regime Sobre-Amortecido');
ylabel('Posição (mm)')
xlabel('Tempo (s)')

%3ºs Gráficos de Posição
figure
hold on
for i = 18:length(ks)
    idx_Pos = find(data(:,i,1));
    plot(0.1*idx_Pos(1:0.2*idx_Pos(end)),data(idx_Pos(1:0.2*idx_Pos(end)),i,1))    
end
legend('K = 0.95','K = 1','K = 2')
title('Regime Instável');
ylabel('Posição (mm)')
xlabel('Tempo (s)')
%----------------------------------------------------------------
%1º Graficos Velocidade
figure
hold on
for i = 1:9
    idx_Vel = find(data(:,i,2));
    plot(0.1*idx_Vel(1:0.2*idx_Vel(end)),data(idx_Vel(1:0.2*idx_Vel(end)),i,2))  
end
legend('K = 0.02','K = 0.03','K = 0.04','K = 0.05','K = 0.06','K = 0.07','K = 0.08','K = 0.09','K = 0.1')
title('Regime Sub-Amortecido');
ylabel('Velocidade (mm/s)')
xlabel('Tempo (s)')

%2º Graficos Velocidade
figure
hold on
for i = 5:8
    idx_Vel = find(data(:,i,2));
    plot(0.1*idx_Vel(1:0.3*idx_Vel(end)),data(idx_Vel(1:0.3*idx_Vel(end)),i,2))      
end
legend('K = 0.2','K = 0.3','K = 0.4','K = 0.5','K = 0.6','K = 0.7','K = 0.8','K = 0.9')
title('Regime Sobre-Amortecido')
ylabel('Velocidade (mm/s)')
xlabel('Tempo (s)')

%3º Graficos Velocidade
figure
hold on
for i = 18:length(ks)
    idx_Vel = find(data(:,i,2));
    plot(0.1*idx_Vel(1:0.2*idx_Vel(end)),data(idx_Vel(1:0.2*idx_Vel(end)),i,2))       
end
legend('K = 0.95','K = 1','K = 2')
title('Regime Instável');
ylabel('Velocidade (mm/s)')
xlabel('Tempo (s)')

%----------------------------------------
%1º Gráfico Tensão
figure
hold on
for i = 1:9
    idx_Volt = find(data(:,i,3));
    plot(0.1*idx_Volt(1:0.6*idx_Volt(end)),data(idx_Volt(1:0.6*idx_Volt(end)),i,3))    
end
legend('K = 0.02','K = 0.03','K = 0.04','K = 0.05','K = 0.06','K = 0.07','K = 0.08','K = 0.09','K = 0.1')
title('Regime Sub-Amortecido');
ylabel('Tensão (V)')
xlabel('Tempo (s)')

%2º Gráfico Tensão
figure
hold on
for i = 10:17
    idx_Volt = find(data(:,i,3));
    plot(0.1*idx_Volt(1:0.2*idx_Volt(end)),data(idx_Volt(1:0.2*idx_Volt(end)),i,3))      
end
legend('K = 0.2','K = 0.3','K = 0.4','K = 0.5','K = 0.6','K = 0.7','K = 0.8','K = 0.9')
title('Regime Sobre-Amortecido')
ylabel('Tensão (V)')
xlabel('Tempo (s)')

%3º Gráfico Tensão
figure
hold on
for i = 18:length(ks)
    idx_Volt = find(data(:,i,3));
    plot(0.1*idx_Volt(1:0.2*idx_Volt(end)) ,data(idx_Volt(1:0.2*idx_Volt(end)) ,i,3))    
end
legend('K = 0.95','K = 1','K = 2')
title('Regime Instável');
ylabel('Tensão (V)')
xlabel('Tempo (s)')