% Step 1
% clear the workspace,command window, previous plot
clear all
close all
clc
% Step 2
% Defining thermodyanamic property
gamma=1.4;
% Step 3
% Defining dimensions of cylinder
bore=0.1;
stroke=0.1;
con_rod=0.2;
% cr is compression ratio of the process, it is very crucial parameter
cr=12;
% Step 4
% Input available in problem statement
% Pressure & Temperature at state 1
p1=101300;
t1=300;
% Temperature at state 3
t3=1500;
% Step 5
% Properties of cyclinder
v_s=(pi/4)*bore^2*stroke;
v_c=v_s/(cr-1);
% Step 6
% Properties at first stage
v1=v_s+v_c;
% Step 7
constant1=p1*v1^gamma;
% Calling the function to determine various points between state1 & 2
v_compression=piston_kinematics(bore,stroke,con_rod,cr,180,0);
p_compression=constant1./(v_compression.^gamma);
% Step 8
% Properties at second stage
% By using various thermodyanamic relation
v2=v_c;
p2=p1*(cr)^gamma;
t2=(p2/(p1*cr))*t1;
% Step 9
% Properties at third stage
% By using various thermodyanamic relation
v3=v2;
p3= (p2*v2*t3)/(v3*t2);
%Step 10
constant2=p3*v3^gamma;
% Calling the function to determine various points between state3 & 4
v_expansion=piston_kinematics(bore,stroke,con_rod,cr,0,180);
p_expansion=constant2./(v_expansion.^gamma);
% Step 11
% Properties at fourth stage
% By using various thermodyanamic relation
v4=v1;
p4=p3*(1/cr)^gamma;
t4=(p4*v4*t3)/(p3*v3);
% Step 12
% Plotting the points
hold on
plot(v1,p1,'o','color','b')
plot(v2,p2,'o','color','b')
plot(v3,p3,'o','color','b')
plot(v4,p4,'o','color','b')
% Step 13
% Plotting the lines
plot(v_compression,p_compression,'color','b','linewidth',1.5)
plot([v2 v3],[p2 p3],'color','r','linewidth',1.5)
plot(v_expansion,p_expansion,'color','g','linewidth',1.5)
plot([v4 v1],[p4 p1],'color','r','linewidth',1.5)
xlabel('Volume (m^3)');
ylabel('Pressure (N/m^2)');
% Step 14
% Thermal Efficiency
thermal_efficiency=(1-(1/cr)^(gamma-1))*100
txt = ['Thermal Efficiency: ' num2str(thermal_efficiency) ' %'];
text(v_compression(120),p_expansion(130)*20,txt,'color','r')