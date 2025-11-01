n=100000;
t=linspace(0,2*10^-3,n);
fs=n/(2*10^-3);

%m1(t)
f=1/(1*10^-3);
m1=sawtooth(-2*pi*f*(t-0.5*10^-3));
subplot(1,2,1)
plot(t,m1)
title('m_1(t)')
xlabel('Time (s)') 
ylabel('Amplitude (V)') 

%m2(t)
m2= (t==0).*0+((t > 0)&(t<0.5*10^-3)).*1+((t > 0.5*10^-3)&(t<1*10^-3)).*0.5+((t > 1*10^-3)&(t<1.5*10^-3)).*-0.5+((t > 1.5*10^-3)&(t<2*10^-3)).*-1;
subplot(1,2,2)
plot(t,m2)
title('m_2(t)')
xlabel('Time (s)') 
ylabel('Amplitude (V)') 

%Carrier
phi=pi/3;
fc=5000;
c1=5*cos(2*pi*fc*t);
c2=5*sin(2*pi*fc*t);

c1_phase_error=5*cos(2*pi*fc*t+phi);
c2_phase_error=5*sin(2*pi*fc*t+phi);

c1_freq_error=5*cos(2.02*pi*fc*t);
c2_freq_error=5*sin(2.02*pi*fc*t);

%QAM Modulation
s=m1.*c1+m2.*c2;

figure
subplot(2,1,1)
plot(t,c1.*m1)
title('Modulation of c_1 by m_1')
xlabel('time(s)')
ylabel('Amplitude(V)')
subplot(2,1,2)
plot(t,c2.*m2)
title('Modulation of c_2 by m_2')
xlabel('time(s)')
ylabel('Amplitude(V)')

plot(t,s)
title('QAM modulated signal')
xlabel('Time (s)') 
ylabel('Amplitude (V)') 

%Receiver
rm1=s.*c1;
rm1=lowpass(rm1,0.1,100);
rm1=lowpass(rm1,0.1,100);
subplot(1,2,1)
plot(t,rm1)
title('m_1(t) Coherently Demodulated and Normalized')
xlabel('Time (s)') 
ylabel('Amplitude (V)')

rm2=s.*c2;
rm2=lowpass(rm2,2200,fs,'ImpulseResponse','iir');
subplot(1,2,2)
plot(t,rm2);
title('m_2(t) Coherently Demodulated and Normalized')
xlabel('Time (s)') 
ylabel('Amplitude (V)') 

%Receiver with phase error
rm1_phase_error=s.*c1_phase_error;
rm1_phase_error=lowpass(rm1_phase_error,2200,fs,'ImpulseResponse','iir');
subplot(1,2,1)
plot(t,rm1_phase_error)
title('m_1(t) Coherent Demodulation with Phase error and Normalized')
xlabel('Time (s)') 
ylabel('Amplitude (V)')

rm2_phase_error=s.*c2_phase_error;
rm2_phase_error=lowpass(rm2_phase_error,2200,fs,'ImpulseResponse','iir');
subplot(1,2,2)
plot(t,rm2_phase_error);
title('m_2(t) Coherent Demodulation with Phase error and Normalized')
xlabel('Time (s)') 
ylabel('Amplitude (V)')

%Receiver with frequency error
rm1_freq_error=s.*c1_freq_error;
rm1_freq_error=lowpass(rm1_freq_error,2200,fs,'ImpulseResponse','iir');
subplot(1,2,1)
plot(t,rm1_freq_error)
title('m_1(t) Coherent Demodulation with Frequency error and Normalized')
xlabel('Time (s)') 
ylabel('Amplitude (V)') 

rm2_freq_error=s.*c2_freq_error;
rm2_freq_error=lowpass(rm2_freq_error,2200,fs,'ImpulseResponse','iir');
subplot(1,2,2)
plot(t,rm2_freq_error);
title('m_2(t) Coherent Demodulation with Frequency error and Normalized')
xlabel('Time (s)') 
ylabel('Amplitude (V)') 

