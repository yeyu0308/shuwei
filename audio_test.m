clear
clc
%��һ���֣�¼������ȡ¼����
[s , fs] = audioread('F:\temp\fash.wav');
%simples = [1,25*fs];    %��ȡǰ10s
%[s , fs] = audioread('F:\temp\fash.wav',simples);
y = s(:,1);
f = fftshift(fft(y));
w = linspace(-fs/2,fs/2,length(y));
plot(w,abs(f));
subplot(111)
%sound(s,fs)


%�ڶ����֣���š�����¼��
audiowrite('F:\temp\fash_0.wav',y,fs);  
audiowrite('F:\temp\fash_fast.wav',y,fs*2); 
audiowrite('F:\temp\fash_slow.wav',y,fs/2); 
%sound(y,fs/2);
%sound(y,fs*2);

f = fftshift(fft(y));
fs_fast = fs*2;
w = linspace(-fs_fast/2,fs_fast/2,length(y));
plot(w,abs(f));
subplot(111)

f = fftshift(fft(y));
fs_slow = fs/2;
w = linspace(-fs_slow/2,fs_slow/2,length(y));
plot(w,abs(f));
subplot(111)


%�������֣���д�����������ź�
T = 1/fs;   %��������
t = (1:length(y))*T;    %����ʱ��
f = fs/8;
w = 2 * pi *f;
%A = 100*exp(-t); 
A = 5;
f_mom = 200;
Y = A*cos(f_mom * t.^2 + w * t + y');
f = fftshift(fft(Y));
w = linspace(-fs/2,fs/2,length(Y));
plot(w,abs(f));
subplot(111)

subplot(211)
plot(t,Y,'r',t,f+f_mom.*t,'b') 
title('SINUSOIDAL PLOT') 
legend('s','f_mom');

subplot(212)
specgram(Y,256,fs)
audiowrite('fish_cos.wav',Y/max(abs(Y))*0.8,fs);
shg



%���Ĳ��֣��ֻ���������
clear
clf

fs=8000;
fftsize=256;
flt=[697,770,852,941];
fht=[1209,1336,1477,1633];
keypad=[14  1  2  3  5  6  7  9 10 11  4  8 12 16 13 15];

sample = input('sample=');
n=1:sample;
h=hann(sample)';

yyy=[];
number = input('Number of Key=');
for i=1:number,
   key = input('Key=');
   key = keypad(key+1);
   col = rem(key,4);
   if col==0,
      col=4;
   end
   row = (key-col)/4+1;
   fl = flt(row)
   fh = fht(col)
   
   dwl = 2*pi*fl/fs;
   dwh = 2*pi*fh/fs;
   y=cos(dwl*n)+cos(dwh*n);   
   
   y = y.*h;
   yyy = [yyy y];
   
end   

subplot(311);plot(yyy)
axis('tight');
xlabel('sample');

subplot(312);specgram(yyy,fftsize,fs)
xlabel('time');

xxx=-fs/2:fs/length(yyy):fs/2-fs/length(yyy);
subplot(313);plot(xxx,abs(fftshift(fft(yyy))))
axis('tight');
xlabel('frequency');
shg
sound(yyy, 8000)
audiowrite('F:temp\call_0.wav', yyy, 8000);

