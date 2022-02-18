clc;
clear;
clearvars;
[tel,fs]= audioread('tel.wav');
disp("- VERİLEN SES -");
ns=length(tel);
t = (1/fs)*(1:ns);
figure (1);
subplot(4,3,1); plot(t,tel);
xlabel("Zaman"); ylabel("Genlik"); title("Plot komutu ile tel.wav");
subplot(4,3,2); stem(t,tel);
xlabel("Zaman"); ylabel("Genlik"); title("Stem komutu ile tel.wav");
d=floor(length(tel)/8);
sound(tel,fs);
pause(2);
L=length(tel);
f = fs*(0:(L/2))/L;

tel1=tel(1:d);
y1=abs(fft(tel1));
Nsamps = length(y1);
f1 = fs*(0:Nsamps-1)/Nsamps;
z1=length(f1)/2;
subplot(4,3,3); plot(f1(1:z1),y1(1:z1));  xlabel('Frekans'); ylabel('Genlik');
j = 1;
for i=1:7
   if i~=4 
     w=tel(i*d:(i+1)*d);
     y=abs(fft(w));
     Nsamps = length(y1);
     f = fs*(0:Nsamps-1)/Nsamps;
     z=length(f)/2;
     subplot(4,3,(j+3)); plot(f(1:z),(y(1:z)));  xlabel('Frekans'); ylabel('Genlik');
      j = j+1;
   end
end

[yeni,fs]= audioread('mynumber.wav');
disp("- KAYDETTİĞİM SES -");
ns=length(yeni);
t = (1/fs)*(1:ns);
figure (2);
subplot(7,2,1); plot(t,yeni); 
xlabel("Zaman"); ylabel("Genlik"); title("Plot komutu ile '05374970187'");
subplot(7,2,2); stem(t,yeni);
xlabel("Zaman"); ylabel("Genlik"); title("Stem komutu ile '05374970187'");
pause(1);
d=floor(length(yeni)/11);
sound(yeni,fs);
w=yeni(1:d);
x=(fft(w));
Nsamps = length(x);
f = fs*(0:Nsamps-1)/Nsamps;
z=length(f)/2;
subplot(7,2,3); plot(f(1:z),abs(x(1:z))); xlabel('Frekans'); ylabel('Genlik');
for i=1:10
    w=yeni(i*d:(i+1)*d);
    x=(fft(w));
    Nsamps = length(x);
    f = fs*(0:Nsamps-1)/Nsamps;
    z1=length(f)/2;
    subplot(7,2,(i+3)); plot(f(1:z),abs(x(1:z))); xlabel('Frekans'); ylabel('Genlik');
end
