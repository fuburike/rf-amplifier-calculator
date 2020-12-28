%Bilateral_test
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

%Gp

Gp_dB = input('Gp in dB? ')

%delta and k
delta = (s11phasor*s22phasor)-(s12phasor*s21phasor);
magDelta = abs(delta);
k = (1-(abs(s11phasor)^2)-(abs(s22phasor)^2)+(abs(delta)^2))/(2*abs(s12phasor*s21phasor))
magDelta

%calcultatin Cp and rp

gp = (10^(Gp_dB/10))/(abs(s21phasor)^2);
C2 = s22phasor-(delta*conj(s11phasor));
Cp = (gp*conj(C2))/(1+gp*((abs(s22phasor)^2)-(abs(delta)^2)));
[Cp_angle, Cp_mag] = cart2pol(real(Cp), imag(Cp));
Cp_mag
Cp_angle = (Cp_angle*180/pi)
rp=sqrt(1-(2*k*abs(s12phasor*s21phasor)*gp)+((abs(s12phasor*s21phasor)^2)*(gp^2)))/abs(1+gp*((abs(s22phasor)^2)-(abs(delta)^2)))

%asking for chosen gamma_L

gammaL = input('gamma L?')
gammaL_mag=gammaL(1,1);
gammaL_angl=gammaL(1,2);
gammaL_phasor = (gammaL_mag)*exp(1i*(gammaL_angl)*pi/180);

%calculating gammaIn and gammaOut

gammaIn_phasor = s11phasor + (s12phasor*s21phasor*gammaL_phasor)/(1-(s22phasor*gammaL_phasor));
disp('')
disp('gammaIn')
[abs(gammaIn_phasor) r2d(angle(gammaIn_phasor))]
disp('')

% gammaOut_phasor = s22phasor + (s12phasor*s21phasor*gammaS_phasor)/(1-(s11phasor*gammaS_phasor));
% disp('gammaOut')
% [abs(gammaOut_phasor) r2d(angle(gammaOut_phasor))]
% disp('')

gamma_S = conj(gammaIn_phasor);
[gamma_S_angle, gamma_S_mag] = cart2pol(real(gamma_S), imag(gamma_S));
gamma_S_mag
gamma_S_angle = (gamma_S_angle*180/pi)

