%��������  AOWriteChannel(obj,ChannelNum,fValue)
%��ڲ���  obj                      ���򿪵Ĵ��ڶ���
%         ChannelNum               ��Ҫд��ͨ����ͨ����
%         fValue                   ��Ҫд��ĵ���ֵֵ��λmA ��Χ4~20mA
%˵   ��  �ú�������дĳ��ͨ���ĵ���ֵ ��λmA
function staus=AOWriteChannel(obj,ChannelNum,fValue)
if(fValue<=4)
    fValue=4;
end
if(fValue>=20)
    fValue=20;
end
AoFlag=0;
low=uint8(bitand(uint16(fValue*100),uint16(255)));
high=uint8(bitshift(uint16(fValue*100),-8));
senddata=[2 6 0 ChannelNum high low];
crccode=CalCheckCRC(senddata);
senddata=[senddata crccode];
fwrite(obj,senddata,'uint8');
pause(0.01);
[RecData,DataLen] = fread(obj,8,'uint8');
RecData=RecData';
for iRow=1:DataLen
    %AO�ж�
    if RecData(1,iRow)==2 && RecData(1,iRow+1)==6 && (iRow+7)<=DataLen
        AoFrame = RecData(1,iRow:iRow+7);
         TempAoFrame=[AoFrame(1,1:6) CalCheckCRC(AoFrame(1,1:6))];
         if isequal(AoFrame,TempAoFrame)
             AoValue=bitor(bitshift(AoFrame(1,5),8),AoFrame(1,6))/100.0; %��λmv
             AoFlag=1;
         end
        break;
    end
end
 if(AoFlag==1)
   staus=1;
   AoFlag=0;
 else
   staus =0; 
 end
end