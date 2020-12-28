%stability script
clc;
clear all;


%convert deg to rad and rad to deg
 d2r = @(x) (x*pi/180);
 r2d = @(x) (x*180/pi);

%S11
s11 = input('S11? ');
s11mag=s11(1,1);
s11angl=s11(1,2);
s11phasor = (s11mag)*exp(1i*(s11angl)*pi/180);

%S12
s12 = input('S12? ');
s12mag=s12(1,1);
s12angl=s12(1,2);
s12phasor = (s12mag)*exp(1i*(s12angl)*pi/180);

%S21
s21 = input('S21? ');
s21mag=s21(1,1);
s21angl=s21(1,2);
s21phasor = (s21mag)*exp(1i*(s21angl)*pi/180);

%S22
s22 = input('S22? ');
s22mag=s22(1,1);
s22angl=s22(1,2);
s22phasor = (s22mag)*exp(1i*(s22angl)*pi/180);

%k and delta

delta = (s11phasor*s22phasor)-(s12phasor*s21phasor);
magDelta = abs(delta);
k = (1-(abs(s11phasor)^2)-(abs(s22phasor)^2)+(abs(delta)^2))/(2*abs(s12phasor*s21phasor))
magDelta

%output stability circle

cL = (conj(s22phasor - delta*conj(s11phasor)))/((abs(s22phasor)^2)-(abs(delta)^2));
disp('')
disp('cL')
[abs(cL) r2d(angle(cL))]
disp('')
rL = abs((s12phasor*s21phasor)/((abs(s22phasor)^2)-(abs(delta)^2)))

%input stability circle

cS = (conj(s11phasor - delta*conj(s22phasor)))/((abs(s11phasor)^2)-(abs(delta)^2));
disp('')
disp('cS')
[abs(cS) r2d(angle(cS))]
disp('')
rS = abs((s12phasor*s21phasor)/((abs(s11phasor)^2)-(abs(delta)^2)))
