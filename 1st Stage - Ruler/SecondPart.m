%2  
clear
close all
clc
index = 0;
i = 1;
figure
Gain = zeros(9,1);
Freq = zeros(9,1);
Amp = zeros(9,1);
Phase = zeros(9,1);
Xmean = zeros(9,1);
RT060_GotoPosition(20);
for f = 0.1:0.1:0.9
    data = zeros(1000,3);
    RT060_GotoPosition(20);
    t = 0;
    tic;
    while t < 3/f
        index = index + 1;
        v = 2.*sin(2.*pi.*f.*t);
        RT060_SetMotorVoltage(v);
        data(index,1) = RT060_GetPosition();
        data(index,2) = t;
        data(index,3) = v;
        t = toc;
    end
    subplot(3,3,i)
    hold on
    idx_1 = find(data(:,1));
    idx_3 = find(data(:,3));
    plot(data(idx_1,2),data(idx_1,1),'g') %Posição
    plot(data(idx_3,2),data(idx_3,3),'r') %Tensão
    title(['Freq = ',num2str(f)]);
    xlabel('Tempo (s)')
    Amp(i) = (max(data(round(0.6*length(idx_1)):length(idx_1),1))-min(data(round(0.6*length(idx_1)):length(idx_1),1)))/2; %Amplitude
    Xmean(i) = mean(data(round(0.6*length(idx_1)):length(idx_1),1)); %Media Posição
    Gain(i) = Amp(i)/2; %Ganho
    Freq(i) = f; %Frequência
    VoltageIndex = find(data(round(0.6*length(idx_3)):length(idx_3),3) == max(data(round(0.6*length(idx_3)):length(idx_3),3)));
    PositionIndex = find(data(round(0.6*length(idx_1)):length(idx_1),1) == max(data(round(0.6*length(idx_1)):length(idx_1),1)));
    Phase(i) = -(data(PositionIndex(1),2)-data(VoltageIndex,2))*2*f*pi; %Fase
    PosT = Xmean(i)+Amp(i)*sin(2*f*pi*data(idx_1,2) + Phase(i));
    plot(data(idx_1,2),PosT,'b--')
    index = 0;
    data = [];
    i = i + 1;
end
RT060_SetMotorVoltage(0);
figure
plot(Freq,Phase)
title('Phase')
xlabel('Freq (Hz)')
ylabel('Phase (rad)')
grid on
figure
Gain = 20.*log10(Gain(:));
plot(Freq,Gain)
title('Gain (dB)')
xlabel('Freq (Hz)')
ylabel('Gain')
grid on

%2.2
Slope1 = (Gain(3)-Gain(1))/0.1;
Slope2 = (Gain(8)-Gain(4))/0.4;

figure
hold on

%2.3
clear
clc
RT060_GotoPosition(20);
timerVal = tic;
RT060_SetMotorVoltage(3);
i = 1;
t(i) = toc(timerVal);
while t(i) <= 5
    Pos(i) = RT060_GetPosition();
    i = i + 1;
    t(i) = toc(timerVal);
end

RT060_SetMotorVoltage(-5);
while t(i) <= 6
    Pos(i) = RT060_GetPosition();
    i = i + 1;
    t(i) = toc(timerVal);
end

RT060_SetMotorVoltage(5);
while t(i) <= 7
    Pos(i) = RT060_GetPosition();
    i = i + 1;
    t(i) = toc(timerVal);
end

Pos(i) = RT060_GetPosition();
RT060_SetMotorVoltage(0);
plot(t,Pos);
title('Position')