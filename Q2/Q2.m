n=100000;
t=linspace(0,2*10^-3,n);
fs=n/(2*10^-3);
%m1(t)
f=1/(1*10^-3);
m1=sawtooth(-2*pi*f*(t-0.5*10^-3));
plot(t,m1)

%m2(t)
m2= (t==0).*0+((t > 0)&(t<0.5*10^-3)).*1+((t > 0.5*10^-3)&(t<1*10^-3)).*0.5+((t > 1*10^-3)&(t<1.5*10^-3)).*-0.5+((t > 1.5*10^-3)&(t<2*10^-3)).*-1;
plot(t,m2)

%Carrier
fc=10000;

%Pulse Modulation for m1
kp=[0.05,1,5,10];
f1=figure;
ax=[ subplot(2,2,2) subplot(2,2,3) subplot(2,2,4)];
s1=0;
for i=1:length(kp)
    s1=1*cos(2*pi*fc*t+kp(i).*m1);
    subplot(2,2,i)
    plot(t,s1)
    title(['Kp=',num2str(kp(i))])
    xlabel('Time(s)')
    ylabel('Amplitude(V)')
end
sgtitle('Pulse Modulation of m1 for different values of Kp')


fc=10^4;
%Frequency Modulation for m2
s2=cos(2*pi*fc.*t+1000.*cumtrapz(t,m2));
subplot(2,1,1)
plot(t,s2)
title('Frequency Modulation of m_2')
xlabel('Time(s)')
ylabel('Amplitude(V)')

%Frequency Modulation for m1
s3=cos(2*pi*fc.*t+2000.*cumtrapz(t,m1));
subplot(2,1,2)
plot(t,s3)
title('Frequency Modulation of m_1')
xlabel('Time(s)')
ylabel('Amplitude(V)')