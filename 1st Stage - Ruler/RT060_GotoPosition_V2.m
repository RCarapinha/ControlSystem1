function [Measure,Time] = RT060_GotoPosition_V2(ReferencePos)
    Measure = zeros(1000,1); %Guarda medidas
    Time = zeros(1000,1); %Guarda tempo
    index = 0;
    timerVal = tic;
    while (1)
        index = index + 1;
        
        if abs(ReferencePos - RT060_GetPosition()) < 30
            Vel = 0.5*sign(ReferencePos - RT060_GetPosition()); 
        else
            Vel = 5*sign(ReferencePos - RT060_GetPosition());
        end
          
        RT060_SetMotorVoltage(Vel);
        Measure(index) = RT060_GetPosition();
        Time(index) = toc(timerVal);

        if abs(ReferencePos - RT060_GetPosition()) < 2
            RT060_SetMotorVoltage(0);
            Measure(index) = RT060_GetPosition();
            Time(index) = toc(timerVal);
            break
        end
    end
    Measure(Measure == 0) = [];
    Time(Time == 0) = [];
end