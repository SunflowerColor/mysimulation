function serial_callback(obj,event)
global AiValue
global DiValue
global AoFlag
global DoFlag
[RecData,DataLen] = fread(obj,obj.bytesavailablefcncount,'uint8');
RecData=RecData';
for iRow=1:DataLen
    %AO判断
    if RecData(1,iRow)==2 && RecData(1,iRow+1)==6 && (iRow+7)<=DataLen
        AoFrame = RecData(1,iRow:iRow+7);
         TempAoFrame=[AoFrame(1,1:6) CalCheckCRC(AoFrame(1,1:6))];
         if isequal(AoFrame,TempAoFrame)
             AoValue=bitor(bitshift(AoFrame(1,5),8),AoFrame(1,6))/100.0; %单位mv
             AoFlag=1;
         end
        break;
    end
    %AI判断
    if RecData(1,iRow)==1 && RecData(1,iRow+1)==3 && (iRow+20)<=DataLen
        AiFrame = RecData(1,iRow:iRow+20);
         TempAiFrame=[AiFrame(1,1:19) CalCheckCRC(AiFrame(1,1:19))];
         if isequal(AiFrame,TempAiFrame)
            AiValue(1)=bitor(bitshift(AiFrame(1,4),8),AiFrame(1,5))/100.0; %单位mv
            AiValue(2)=bitor(bitshift(AiFrame(1,6),8),AiFrame(1,7))/100.0; %单位mv
            AiValue(3)=bitor(bitshift(AiFrame(1,8),8),AiFrame(1,9))/100.0; %单位mv
            AiValue(4)=bitor(bitshift(AiFrame(1,10),8),AiFrame(1,11))/100.0; %单位mv
            AiValue(5)=bitor(bitshift(AiFrame(1,12),8),AiFrame(1,13))/100.0; %单位mv
            AiValue(6)=bitor(bitshift(AiFrame(1,14),8),AiFrame(1,15))/100.0; %单位mv
            AiValue(7)=bitor(bitshift(AiFrame(1,16),8),AiFrame(1,17))/100.0; %单位mv
            AiValue(8)=bitor(bitshift(AiFrame(1,18),8),AiFrame(1,19))/100.0; %单位mv          
         end
        break; 
    end
    if RecData(1,iRow)==3 && RecData(1,iRow+1)==2 && (iRow+5)<=DataLen
        DiFrame = RecData(1,iRow:iRow+5);
         TempDiFrame=[DiFrame(1,1:4) CalCheckCRC(DiFrame(1,1:4))];
         if isequal(DiFrame,TempDiFrame)
            DiValue=DiFrame(1,4);%个通道开关量
         end
        break; 
    end
    if RecData(1,iRow)==3 && RecData(1,iRow+1)==15 && (iRow+7)<=DataLen
        DOFrame = RecData(1,iRow:iRow+7);
         TempDOFrame=[DOFrame(1,1:6) CalCheckCRC(DOFrame(1,1:6))];
         if isequal(DOFrame,TempDOFrame)
            DoFlag = 1;
         end
        break; 
    end
end
end