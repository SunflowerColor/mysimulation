%��������  ChannelsStatus = DIReadChannel(obj,StartChannelNo,ChannelNum)
%��ڲ���  obj                      ���򿪵Ĵ��ڶ���
%         StartChannelNo           ��Ҫ��ȡͨ���Ŀ�ʼͨ����
%         ChannelNum               ��Ҫ��ȡ��ͨ������
%���ڲ��� ChannelsStatus           ��Ҫ��ȡͨ���ĵ�״̬ 
%˵   ��  �ú������ڶ�ȡĳ��ͨ����״̬
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
            DiValue=DiFrame(1,4);%��ͨ��������
         end
        break; 
end
ChannelsStatus = DiValue;
end