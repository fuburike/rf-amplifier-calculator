%Getting gammaS Given gammaL;
clear all;
clc

%convert deg to rad and rad to deg
 d2r = @(x) (x*pi/180);
 r2d = @(x) (x*180/pi);
% 
% %gammaS
% gammaS = input('gammaOpt? ');
% gammaS_mag=gammaS(1,1);
% gammaS_angl=gammaS(1,2);
% gammaS_phasor = (gammaS_mag)*exp(1i*(gammaS_angl)*pi/180);

%gammaL
gammaL = input('gammaL? ');
gammaL_mag=gammaL(1,1);
gammaL_angl=gammaL(1,2);
gammaL_phasor = (gammaL_mag)*exp(1i*(gammaL_angl)*pi/180);

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

%calculating gammaIn
gammaIn_phasor = s11phasor + (s12phasor*s21phasor*gammaL_phasor)/(1-(s22phasor*gammaL_phasor));
disp('')
disp('gammaIn')
[abs(gammaIn_phasor) r2d(angle(gammaIn_phasor))]
disp('')

% %calculating gammaOut
% gammaOut_phasor = s22phasor + (s12phasor*s21phasor*gammaS_phasor)/(1-(s11phasor*gammaS_phasor));
% disp('')
% disp('gammaOut')
% [abs(gammaOut_phasor) r2d(angle(gammaOut_phasor))]
% disp('')

%Getting gammaS
gammaS_phasor = (abs(gammaIn_phasor))*exp(1i*(r2d(angle(conj(gammaIn_phasor))))*pi/180);
disp('')
disp('gammaS')
[abs(gammaS_phasor) r2d(angle(gammaS_phasor))]
disp('')
