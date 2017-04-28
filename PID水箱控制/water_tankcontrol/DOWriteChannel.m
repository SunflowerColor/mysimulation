%函数名称  DOWriteChannel(obj,Status)
%入口参数  obj                      被打开的串口对象
%         Status                   所要写入通道的状态 八个通道一起写
%说   明  该函数用于写八个通道的状态
function status = DOWriteChannel(obj,Status)
DoFlag=0;
senddata=[4 15 0 0 0 0 0 Status];
crccode=CalCheckCRC(senddata);
senddata=[senddata crccode];
fwrite(obj,senddata,'uint8');
pause(0.01);
[RecData,DataLen] = fread(obj,8,'uint8');
RecData=RecData';
for iRow=1:DataLen
    if RecData(1,iRow)==3 && RecData(1,iRow+1)==15 && (iRow+7)<=DataLen
        DOFrame = RecData(1,iRow:iRow+7);
         TempDOFrame=[DOFrame(1,1:6) CalCheckCRC(DOFrame(1,1:6))];
         if isequal(DOFrame,TempDOFrame)
            DoFlag = 1;
         end
        break; 
    end
end
 if(DoFlag==1)
   status=1;
   DoFlag=0;
 else
   status =0; 
 end
end