%函数名称  ChannelsStatus = DIReadChannel(obj,StartChannelNo,ChannelNum)
%入口参数  obj                      被打开的串口对象
%         StartChannelNo           所要读取通道的开始通道号
%         ChannelNum               所要读取的通道个数
%出口参数 ChannelsStatus           所要读取通道的的状态 
%说   明  该函数用于读取某个通道的状态
function ChannelsStatus = DIReadChannel(obj,StartChannelNo,ChannelNum)
global DiValue
senddata=[3 2 0 StartChannelNo 0 ChannelNum];
crccode=CalCheckCRC(senddata);
senddata=[senddata crccode];
fwrite(obj,senddata,'uint8');
 pause(0.01);
[RecData,DataLen] = fread(obj,6,'uint8');
RecData=RecData';
for iRow=1:DataLen
    if RecData(1,iRow)==3 && RecData(1,iRow+1)==2 && (iRow+5)<=DataLen
           DiFrame = RecData(1,iRow:iRow+5)
%          TempDiFrame=[DiFrame(1,1:4) CalCheckCRC(DiFrame(1,1:4))];
%          if isequal(DiFrame,TempDiFrame)
            DiValue=DiFrame(1,4);%个通道开关量
         end
        break; 
end
ChannelsStatus = DiValue;
end