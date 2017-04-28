%函数名称  fChannelVoltage = AIReadChannel(obj,StartChannelNo,ChannelNum)
%入口参数  obj                      被打开的串口对象
%         StartChannelNo            所要读取通道的开始通道号
%         ChannelNum                所要读取的通道个数
%出口参数 fChannelVoltage            所要读取通道的电压值 单位mv
%说   明  该函数用于读取某个通道的电压值 单位mv
function fChannelVoltage = AIReadChannel(obj,StartChannelNo,ChannelNum)
global AiValue
senddata=[1 3 0 StartChannelNo 0 ChannelNum];
crccode=CalCheckCRC(senddata);
senddata=[senddata crccode];
fwrite(obj,senddata,'uint8');
pause(0.01);
[RecData,DataLen] = fread(obj,ChannelNum*2+5,'uint8');
RecData=RecData';
for iRow=1:DataLen
    %AI判断
    if RecData(1,iRow)==1 && RecData(1,iRow+1)==3 && (iRow+ChannelNum*2+4)<=DataLen
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
end
fChannelVoltage = AiValue;
end