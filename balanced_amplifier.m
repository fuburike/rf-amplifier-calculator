%Bilateral_test
clc;
clear all;

%convert deg to rad and rad to deg
 d2r = @(x) (x*pi/180);
 r2d = @(x) (x*180/pi);

%S11a
s11a = input('S11a? ');
s11a_mag=s11a(1,1);
s11a_angl=s11a(1,2);
s11a_phasor = (s11a_mag)*exp(1i*(s11a_angl)*pi/180);

%S12a
s12a = input('S12a? ');
s12a_mag=s12a(1,1);
s12a_angl=s12a(1,2);
s12a_phasor = (s12a_mag)*exp(1i*(s12a_angl)*pi/180);

%S21a
s21a = input('S21a? ');
s21a_mag=s21a(1,1);
s21a_angl=s21a(1,2);
s21a_phasor = (s21a_mag)*exp(1i*(s21a_angl)*pi/180);

%S22a
s22a = input('S22a? ');
s22a_mag=s22a(1,1);
s22a_angl=s22a(1,2);
s22a_phasor = (s22a_mag)*exp(1i*(s22a_angl)*pi/180);

%S11b
s11b = input('S11b? ');
s11b_mag=s11b(1,1);
s11b_angl=s11b(1,2);
s11b_phasor = (s11b_mag)*exp(1i*(s11b_angl)*pi/180);

%S12b
s12b = input('S12b? ');
s12b_mag=s12b(1,1);
s12b_angl=s12b(1,2);
s12b_phasor = (s12b_mag)*exp(1i*(s12b_angl)*pi/180);

%S21b
s21b = input('S21b? ');
s21b_mag=s21b(1,1);
s21b_angl=s21b(1,2);
s21b_phasor = (s21b_mag)*exp(1i*(s21b_angl)*pi/180);

%S22b
s22b = input('S22b? ');
s22b_mag=s22b(1,1);
s22b_angl=s22b(1,2);
s22b_phasor = (s22b_mag)*exp(1i*(s22b_angl)*pi/180);

%calculating s-parameters

s11_phasor = (exp(-1i*pi)/2)*(s11a_phasor - s11b_phasor);
s21_phasor = (exp(-1i*(pi/2))/2)*(s21a_phasor + s21b_phasor);
s12_phasor = (exp(-1i*(pi/2))/2)*(s12a_phasor + s12b_phasor);
s22_phasor = (exp(-1i*pi)/2)*(s22a_phasor - s22b_phasor);

%Getting s11
disp('')
disp('S11')
[abs(s11_phasor) r2d(angle(s11_phasor))]
disp('')

%mag s11
% mag_s11=0.5*abs(s11a_phasor-s11b_phasor)

%Getting s21
disp('')
disp('S21')
[abs(s21_phasor) r2d(angle(s21_phasor))]
disp('')

%mag s21
% mag_s21=0.5*abs(s21a_phasor+s21b_phasor)

%Getting s12
disp('')
disp('S12')
[abs(s12_phasor) r2d(angle(s12_phasor))]
disp('')

%mag s12
% mag_s12=0.5*abs(s12a_phasor+s12b_phasor)

%Getting s22
disp('')
disp('S22')
[abs(s22_phasor) r2d(angle(s22_phasor))]
disp('')

%mag s22
% mag_s22=0.5*abs(s22a_phasor-s22b_phasor)

%VSWR 

VSWR_in = (1+ abs(s11_phasor))/(1-abs(s11_phasor))

VSWR_out = (1+ abs(s22_phasor))/(1-abs(s22_phasor))

%Transducer Power Gain
GT = (abs(s21_phasor))^2
GT_dB = 10*log10(GT)

%If A fails to operate
GT_B = (0.5^2)*(abs(s21a_phasor))^2
GT_B_dB = 10*log10(GT_B)

%If B fails to operate
GT_A = (0.5^2)*(abs(s21b_phasor))^2
GT_A_dB = 10*log10(GT_A)

