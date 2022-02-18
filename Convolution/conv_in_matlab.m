clc;
clear;
clearvars;
n=input('1. ayrık zamanlı işaretin boyutunu giriniz: ');
for i=1:1:n
    fprintf('x(%d) : ',i); 
    x(i) = input(' ');
end
fprintf('Zaman indislerini giriniz:\n ');
for i=1:1:n 
    fprintf('indis %d : ',i); 
    xn(i) = input('');
end
m=input('2. ayrık zamanlı işaretin boyutunu giriniz:');
for i=1:1:m
    fprintf('h(%d) : ',i); 
    h(i) = input('');
end
fprintf('Zaman indislerini giriniz:\n ');
for i=1:1:m
    fprintf('indis %d : ',i); 
    hn(i) = input('');
end  
[y, yn] = my_conv(x, xn, h, hn);
  
figure;
subplot(4,2,1); stem(xn,x,'g'); xlabel('n');
ylabel('x[n]');  
title('X[n]');
subplot(4,2,2); stem(hn,h,'b'); xlabel('n');
ylabel('h[n]'); 
title('H[n]');
subplot(4,2,3); stem(yn, y,'r'); xlabel('n');
ylabel('y[n]');
title('Convolution without conv');

x_x= xn(1):xn(length(xn));
x_h =hn(1):hn(length(hn));
y2=conv(x,h);
x_y= (x_x(1)+x_h(1)):(x_x(end)+x_h(end));
subplot(4,2,4); stem(x_y,y2,'p'); xlabel('n');
ylabel('y[n]')
title('Convolution with conv'); 
fprintf('x[n] = ')
disp(x)
fprintf('h[n] = ')
disp(h)
fprintf('myconv y[n] = ')
disp(y)
fprintf('conv y[n] = ')
disp(y2)
pause(2);

recObj = audiorecorder; 
disp('Start speaking for 5 seconds.')
recordblocking(recObj, 5); 
disp('End of Recording.'); 
x1 = getaudiodata(recObj); 
disp('wait for 2 seconds...')
pause(2);
recObj = audiorecorder; 
disp('Start speaking for 10 seconds.')
recordblocking(recObj, 10); 
disp('End of Recording.'); 
x2 = getaudiodata(recObj);

Y=zeros(1,801);
Y(1)=1;
Y(401)=0.4;
Y(801)=0.4;

Y1=conv(x1,Y);
subplot(4,2,5); stem(Y1); title('Y1 with conv');

Y2=conv(x2,Y);
subplot(4,2,6); stem(Y2); title('Y2 with conv');

for i=1:1:length(Y)
    lY(i)=i;
end
for i=1:1:length(x1)
    lx1(i)=i;
end
My_Y1=my_conv(x1,lx1,Y,lY);
subplot(4,2,7); stem(My_Y1); title('Y1 without conv');

for i=1:1:length(x2)
    lx2(i)=i;
end
My_Y2=my_conv(x2,lx2,Y,lY);
subplot(4,2,8); stem(My_Y2); title('Y2 without conv');

sound(Y1);
pause(2);
sound(Y2);
pause(2);
sound(My_Y1);
pause(2);
sound(My_Y2);

function [y, yn] = my_conv(x, xn, h, hn)
    ynbegin = xn(1) + hn(1);
    ynend = xn(length(xn)) + hn(length(hn));
    yn = ynbegin : ynend;
    y = calconv(x, h);
end
 
function [y] = calconv(x, h)
    l1 = length(x);
    l2 = length(h);
    N = l1 + l2 - 1;
    for n = 1:1:N
        y(n) = 0;
        for k = 1 : 1 : l1
            if(n - k + 1 >= 1 && n - k + 1 <= l2)
                y(n) = y(n) + x(k) * h(n - k + 1);
            end
        end
    end
end


