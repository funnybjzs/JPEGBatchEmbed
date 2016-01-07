function JLSBM(infiles, outfiles)
A=jpeg_read(infiles.File1);
ti=A.coef_arrays{1,1};
f=fopen(infiles.MsgFile,'rb');
try
    msg=uint8(fread(f));
catch ex
end
fclose(f);
msglen=numel(msg);
msg=[floor(msglen/256/256); mod(floor(msglen/256), 256); mod(msglen, 256); msg];
%msglen: ��Ϣ����λ����
msglen=numel(msg)*8;
%nti: ����cover�ֽ���
nti=numel(ti);
%changemask: 0ϵ����Ƕ�룬ֱ��ϵ����Ƕ�룻��Ƕ���ֽڱ��Ϊ1����ȡ����(��������)
changemask = (ti~=0);
changemask(1:8:end, 1:8:end) = 0;
changemask=find(changemask);

sti=size(ti);
ti=reshape(ti,1,nti);
%pos�������ϴ�������
rs=RandStream.create('mrg32k3a','NumStreams',1,'Seed',infiles.PosKey);
pos=changemask(rs.randperm(size(changemask,1)));
%sgn:���������+/- 1������msglen
rs2=RandStream.create('mrg32k3a','NumStreams',1,'Seed',infiles.IncDecKey);
sgn=rs2.rand(1,msglen);
sgn(sgn<0.5)=-1;
sgn(sgn>=0.5)=1;
%msgInbits��msg����
if (msglen>size(changemask,1)), msglen=size(changemask,1); end
msgInBits=GetBitArray(msg,1,msglen);

t2=ti(pos(1:msglen));
s=sign(t2); %�����������
t2_conv=s.*t2; %ȫ��ȡ��
posmod=bitxor(msgInBits.',logical(bitand(t2_conv,1))); %���λ�Ƿ�����Ϣ������ͬ
t2t=double(t2(posmod))+double(int8(sgn(posmod))); %t2tΪǶ������ֵ
t2t(t2t<-1024)=-1023;t2t(t2t>1023)=1022;
t2(posmod)=t2t;
ti(pos(1:msglen))=t2;
ti=reshape(ti,sti);
A.coef_arrays{1,1}=ti;
jpeg_write(A,outfiles.File1);
end