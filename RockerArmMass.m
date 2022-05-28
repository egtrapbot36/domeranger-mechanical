clc; clear; close all;

%Vibrational constants
FOS = 1.25; %Factor of Safety
w = FOS*150; %minimum desired fundamental frequency (as per GEVS) [Hz]

C = 15.418; %first mode constant

%Properties of 6061 Al.
d = 2700; %density [kg/m^3]
E = 69*10^9; %Youngs modulus [Pa]
S_f = 299*10^6; %flexural strength of Al. 6061 [Pa]

%Mode calcs
L = (0:0.01:0.75); %half the length of rocker arm
h = sqrt( (48*pi^2*w^2*d*L.^4) / (C^2*E) );
m = d*(h.^2).*(2*L); %mass of the rocker [kg]


%Bending stress calcs
m_rover = 30; %maximum mass of rover
g = 9.81;
F = m_rover*g/2; %1/4 of the rover weight on a single wheel
M = F*L;
bend_FOS = 3;
safe_bend_stress = S_f/bend_FOS; %bending stress, [Pa]
h_safe = (6*M/safe_bend_stress).^(1/3);

%Plotting
yyaxis left
plot(2*L,m); %plot the beam mass vs. rover track width 
ylabel("Rocker Mass [kg]");

yyaxis right
hold on
plot(2*L,h*1000); %plot the beam thickness vs. rover track width 
ylabel("Rocker Thickness (h) - [mm]");
plot(2*L,h_safe*1000);

title("Rocking Axle Suspension: Beam Mass & Dimensions vs. Rover Track Width");
stxt = ['FOS = ',num2str(FOS),', 1st Mode = ',num2str(w),' Hz,',...
        ' Bend Stress FOS = ', num2str(bend_FOS)];
subtitle(stxt);
xlabel("Track Width (2L) - [m]");
legend("Mass vs. Length","Thickness via Vibrational Analysis","Thickness via Bend Stress Analysis",'Location','Northwest');
hold off

