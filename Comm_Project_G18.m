clc
close all
clear all
%part 1 All Team G18
endtime = 2/100;
fs = 200000;
step =1/fs;
t = -endtime:step:endtime;
m = 2* power(sinc(200*t),2)+ power(sinc(400*t),2);
figure(1)
plot(t*1e3,m,'r')
xlabel('Time');
ylabel('M(t)');
title('Original function');
N = length(m);
firstsigtrans = abs(1/N*fftshift(fft(m)));
f = -fs:1/endtime:fs;
figure(2);
plot(f,firstsigtrans,'r');
xlabel('Frequency');
ylabel('M(f)');
title('First signal fourier transform');
xlim([-2000,2000]);
%part 5 Ahmed Ayman Ahmed Hassan 1700037
fm=500;
fc=40e3;
kp=10;
t=-0.002:0.000001:0.002;
d=sinc(2*pi*fm*t);
m=2*d.^3;
A=2*pi*fc*t+kp*m;
A1=(kp/(2*pi))*m;
fi=gradient(A1,t);
s=cos(A);
figure(3);
subplot(211);
plot(t,s);
xlabel('Time');
ylabel('S(t)');
xlim([-0.0002 0.0002]);
title('PM modulated signal');
subplot(212);
plot(t,fi);
xlabel('Time');
ylabel('Fi(t)');
title('Deviation of inst. frequency');
figure(4);
subplot(211);
A=2*pi*fc*t+1*m;
s=cos(A);
plot(t,s);
xlabel('Time');
ylabel('S(t)');
xlim([-0.0002 0.0002]);
title('PM modulated signal@kp=1');
subplot(212);
A=2*pi*fc*t+1000*m;
s=cos(A);
plot(t,s);
xlabel('Time');
ylabel('S(t)');
xlim([-0.0002 0.0002]);
title('PM modulated signal@kp=1000');
figure(5);
A=2*pi*fc*t+kp*m;
s=cos(A);
spectrogram(s,[],[],[],fc);
title('Spectrogram of modulated signal');
figure(6);
A=2*pi*fc*t+100*m;
s=cos(A);
spectrogram(s,[],[],[],fc);
title('Spectrogram of modulated signal@ kp=100');
figure(7);
A=2*pi*fc*t+kp*m;
s=cos(A);
N= length(s);
X=fftshift(fft(s,N));
fs=1e6;
f = -fs/2:fs/N:fs/2-1;
plot(f,abs(X));
title('Amplitude Spectrum S(f)');
xlabel('Frequency');
ylabel('S(f)');
xlim([-1e5 1e5]);
d=sinc(2*pi*fm*t);
m=2*d.^3;
dm=gradient(m,t);  %deltaf=kp*max(dm/dt)
max=max(dm);    %get carson's rule bandwidth 
deltaf=(10/(2*pi))*max; 
%part 6 All Team G18
f=4000;
t = 0.000001:0.000001:0.001;
theta=(unifrnd(0,2*pi,1,1000));
figure(8)
for inx = 1:5
    x = cos ( (2*pi*f*t) + theta(1,inx*200) );
    subplot ( 5 , 1 ,inx);
    plot(t,x);
    xlabel('Time');
    ylabel(['X_',num2str(inx),'(t)']);
end
suptitle('Different Samples of Process X(t)');
z=zeros(1,1000);
u=ones(1,1000);
timeavg =  mean(cos ( 2 * pi * f * t + theta ( 1,800 ) ));
g=u*timeavg;
ensavg = mean ( cos ( 2 * pi * f* 0.0001 + theta ) );
j=u*ensavg;
figure(9);
subplot(2,1,1);
plot (t,j,'r-',t,z,'g-');
legend('Simulated','Theoretical');
title('Ensemble Average Plot');
xlabel('Time');
ylabel('Ensemble Average of X(t)');
subplot(2,1,2);
plot(t,g);
title('Time Average Plot');
xlabel('Time');
ylabel('Time Average of X(t)');
figure(10);
au=xcorr(x,'unbiased');
l = length(au);
k = 1: 1 : l;
plot(k,au);
title('Time Autocorrelation Function Plot');
xlabel('Time Lag');
ylabel('Autocorrelation Function');
