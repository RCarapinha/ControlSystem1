function [] = RT060_GotoPosition(ReferencePos)
    RT060_SetMotorVoltage(0);
    while (1)
        if abs(ReferencePos - RT060_GetPosition()) < 30
            Speed = 0.5*sign(ReferencePos - RT060_GetPosition()); 
        else
            Speed = 5*sign(ReferencePos - RT060_GetPosition());
        end
          
        RT060_SetMotorVoltage(Speed);
        if abs(ReferencePos - RT060_GetPosition()) < 2
            RT060_SetMotorVoltage(0);
            break
        end
    end
end