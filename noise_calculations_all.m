%noise calculations;
clear all;
clc

%convert deg to rad and rad to deg
 d2r = @(x) (x*pi/180);
 r2d = @(x) (x*180/pi);

%gammaS
gammaS = input('gammaOpt? ');
gammaS_mag=gammaS(1,1);
gammaS_angl=gammaS(1,2);
gammaS_phasor = (gammaS_mag)*exp(1i*(gammaS_angl)*pi/180);

% %gammaL
% gammaL = input('gammaL? ');
% gammaL_mag=gammaL(1,1);
% gammaL_angl=gammaL(1,2);
% gammaL_phasor = (gammaL_mag)*exp(1i*(gammaL_angl)*pi/180);

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

%Fmin
Fmin = input('Fmin in dB? ');

%Rn
Rn = input('Rn in ohms? ');

%k and delta

%k and delta
delta = (s11phasor*s22phasor)-(s12phasor*s21phasor);
magDelta = abs(delta);
k = (1-(abs(s11phasor)^2)-(abs(s22phasor)^2)+(abs(delta)^2))/(2*abs(s12phasor*s21phasor))
magDelta

if k<1
    
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
    
end

%calculating gammaOut
gammaOut_phasor = s22phasor + (s12phasor*s21phasor*gammaS_phasor)/(1-(s11phasor*gammaS_phasor));
disp('')
disp('gammaOut')
[abs(gammaOut_phasor) r2d(angle(gammaOut_phasor))]
disp('')

%Getting gammaL
gammaL_phasor = (abs(gammaOut_phasor))*exp(1i*(r2d(angle(conj(gammaOut_phasor))))*pi/180);
disp('')
disp('gammaL')
[abs(gammaL_phasor) r2d(angle(gammaL_phasor))]
disp('')

%calculating gammaIn
gammaIn_phasor = s11phasor + (s12phasor*s21phasor*gammaL_phasor)/(1-(s22phasor*gammaL_phasor));
disp('')
disp('gammaIn')
[abs(gammaIn_phasor) r2d(angle(gammaIn_phasor))]
disp('')


%calculating Gt Gp Ga

% Gt = ((1-(abs(gammaS_phasor))^2)/((abs(1-gammaIn_phasor*gammaS_phasor))^2))*((abs(s21phasor))^2)*((1-(abs(gammaL_phasor))^2)/((abs(1-s22phasor*gammaL_phasor))^2))
% 
% GtdB = 10*log10(Gt)
% 
% Gp = (1/(1-(abs(gammaIn_phasor))^2))*((abs(s21phasor))^2)*((1-(abs(gammaL_phasor))^2)/((abs(1-s22phasor*gammaL_phasor))^2))
% 
% GpdB = 10*log10(Gp)

Ga = ((1-(abs(gammaS_phasor))^2)/((abs(1-s11phasor*gammaS_phasor))^2))*((abs(s21phasor))^2)*(1/(1-(abs(gammaOut_phasor))^2))

GadB = 10*log10(Ga)

%maximum transducer gain

GT_max = (abs(s21phasor)/abs(s12phasor))*(k-sqrt((k^2)-1))
GT_max_dB = 10*log10(GT_max)

%G_MSG

G_MSG = (abs(s21phasor)/abs(s12phasor))
G_MSG_dB = 10*log10(G_MSG)

%asking number of circles
number_circles = input('How many noise circles will you draw? ');

for index = 1:number_circles
    
    %Fi
    Fi = input('Fi in dB? ');

    %Calculating Ni
    Ni=((10^(Fi/10)-10^(Fmin/10))/(4*(Rn/50)))*((abs(1+gammaS_phasor))^2)

    %calcultatin C_Fi and r_Fi
    C_Fi = gammaS_phasor/(1+Ni);
    [C_Fi_angle, C_Fi_mag] = cart2pol(real(C_Fi), imag(C_Fi));
    C_Fi_mag
    C_Fi_angle = (C_Fi_angle*180/pi)
    r_Fi=(1/(1+Ni))*(sqrt((Ni^2)+Ni*(1-(abs(gammaS_phasor))^2)))
    
end
