%power gain script
clc;
clear all;

%convert deg to rad and rad to deg
 d2r = @(x) (x*pi/180);
 r2d = @(x) (x*180/pi);

%Source Voltage
sourceVoltage = input('E? ');
sourceVoltage_mag=sourceVoltage(1,1);
sourceVoltage_angl=sourceVoltage(1,2);
sourceVoltage_phasor = (sourceVoltage_mag)*exp(1i*(sourceVoltage_angl)*pi/180);

%Source Impedance
sourceImpedance = input('Z1? ');
sourceImpedance_mag=sourceImpedance(1,1);
sourceImpedance_angl=sourceImpedance(1,2);
sourceImpedance_phasor = (sourceImpedance_mag)*exp(1i*(sourceImpedance_angl)*pi/180);

%Load Impedance
loadImpedance = input('Z2? ');
loadImpedance_mag=loadImpedance(1,1);
loadImpedance_angl=loadImpedance(1,2);
loadImpedance_phasor = (loadImpedance_mag)*exp(1i*(loadImpedance_angl)*pi/180);

%gammaS
gammaS = input('gammaS? ');
gammaS_mag=gammaS(1,1);
gammaS_angl=gammaS(1,2);
gammaS_phasor = (gammaS_mag)*exp(1i*(gammaS_angl)*pi/180);

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

%calculating gammaIn and gammaOut

gammaIn_phasor = s11phasor + (s12phasor*s21phasor*gammaL_phasor)/(1-(s22phasor*gammaL_phasor));
disp('')
disp('gammaIn')
[abs(gammaIn_phasor) r2d(angle(gammaIn_phasor))]
disp('')

gammaOut_phasor = s22phasor + (s12phasor*s21phasor*gammaS_phasor)/(1-(s11phasor*gammaS_phasor));
disp('gammaOut')
[abs(gammaOut_phasor) r2d(angle(gammaOut_phasor))]
disp('')

%calculating Gt Gp Ga

Gt = ((1-(abs(gammaS_phasor))^2)/((abs(1-gammaIn_phasor*gammaS_phasor))^2))*((abs(s21phasor))^2)*((1-(abs(gammaL_phasor))^2)/((abs(1-s22phasor*gammaL_phasor))^2))

GtdB = 10*log10(Gt)

Gp = (1/(1-(abs(gammaIn_phasor))^2))*((abs(s21phasor))^2)*((1-(abs(gammaL_phasor))^2)/((abs(1-s22phasor*gammaL_phasor))^2))

GpdB = 10*log10(Gp)

Ga = ((1-(abs(gammaS_phasor))^2)/((abs(1-s11phasor*gammaS_phasor))^2))*((abs(s21phasor))^2)*(1/(1-(abs(gammaOut_phasor))^2))

GadB = 10*log10(Ga)

%calculating Ms

Ms = ((1-(abs(gammaS_phasor)^2))*(1-(abs(gammaIn_phasor)^2)))/(abs(1-gammaS_phasor*gammaIn_phasor)^2);
Pavs = ((sourceVoltage(1,1))^2)/(8*real(sourceImpedance_phasor))
Pin = Pavs*Ms
Pl=Gt*Pavs
Pavn=Ga*Pavs