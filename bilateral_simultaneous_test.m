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

%k and delta

delta = (s11phasor*s22phasor)-(s12phasor*s21phasor);
magDelta = abs(delta);
k = (1-(abs(s11phasor)^2)-(abs(s22phasor)^2)+(abs(delta)^2))/(2*abs(s12phasor*s21phasor))
magDelta

%calculate gamma_s and gamma_l

B1 = 1 + abs(s11phasor)^2  - abs(s22phasor)^2 - magDelta^2;
B2 = 1 + abs(s22phasor)^2  - abs(s11phasor)^2 - magDelta^2;
C1 = s11phasor - delta*conj(s22phasor);
C2 = s22phasor - delta*conj(s11phasor);

gamma_s = (B1 - sqrt((B1^2)-4*(abs(C1)^2)))/(2*C1);

[gamma_s_angle, gamma_s_mag] = cart2pol(real(gamma_s), imag(gamma_s));

gamma_s_mag
gamma_s_angle = (gamma_s_angle*180/pi)

gamma_l = (B2 - sqrt((B2^2)-4*(abs(C2)^2)))/(2*C2);

[gamma_l_angle, gamma_l_mag] = cart2pol(real(gamma_l), imag(gamma_l));

gamma_l_mag
gamma_l_angle = (gamma_l_angle*180/pi)

%maximum transducer gain

GT_max = (abs(s21phasor)/abs(s12phasor))*(k-sqrt((k^2)-1))
GT_max_dB = 10*log10(GT_max)

%G_MSG

G_MSG = (abs(s21phasor)/abs(s12phasor))
G_MSG_dB = 10*log10(G_MSG)