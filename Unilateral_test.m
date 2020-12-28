%Unilateral Calculation
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

%GMax

GsMax = 1/(1-(abs(s11phasor)^2))
GsMax_dB = 10*log10(1/(1-(abs(s11phasor)^2)))
GlMax = 1/(1-(abs(s22phasor)^2))
GlMax_dB = 10*log10(1/(1-(abs(s22phasor)^2)))
G0 = abs(s21phasor)^2
G0_dB= 10*log10(abs(s21phasor)^2)
GTU_Max_dB=GsMax_dB+GlMax_dB+G0_dB

%0dB circle through the center of the smith chart
gs_0dB  = 1/GsMax;
center_s_0dB = (gs_0dB*conj(s11phasor))/(1-(abs(s11phasor)^2)*(1-gs_0dB));
mag_center_s_0dB = abs(center_s_0dB)
angle_center_s_0dB = (angle(center_s_0dB)*180/pi)
radius_s_0dB = abs(s11phasor)/(1+(abs(s11phasor)^2))

gl_0dB  = 1/GlMax;
center_l_0dB = (gl_0dB*conj(s22phasor))/(1-(abs(s22phasor)^2)*(1-gl_0dB));
mag_center_l_0dB = abs(center_l_0dB)
angle_center_l_0dB = (angle(center_l_0dB)*180/pi)
radius_l_0dB = abs(s22phasor)/(1+(abs(s22phasor)^2))

%2dB circle

gs_2dB  = 1.59/GsMax;
center_s_2dB = (gs_2dB*conj(s11phasor))/(1-(abs(s11phasor)^2)*(1-gs_2dB));
mag_center_s_2dB = abs(center_s_2dB)
angle_center_s_2dB = (angle(center_s_2dB)*180/pi)
radius_s_2dB = (sqrt(1-gs_2dB)*(1-(abs(s11phasor)^2)))/(1-(abs(s11phasor)^2)*(1-gs_2dB))

% gl_2dB  = 1.59/GlMax;
% center_l_2dB = (gl_2dB*conj(s22phasor))/(1-(abs(s22phasor)^2)*(1-gl_2dB));
% mag_center_l_2dB = abs(center_l_2dB)
% radius_l_2dB = (sqrt(1-gl_2dB)*(1-(abs(s22phasor)^2)))/(1-(abs(s22phasor)^2)*(1-gl_2dB))
