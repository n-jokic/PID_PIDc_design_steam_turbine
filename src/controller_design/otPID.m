function [C, fval, K, Ki, Kd, Tf] = otPID (G, H, Mn, Ms, idx_type,t_end)
% Milan R. Rapaic, Tomislav B. Sekara, 2008-11-26..30

% The initial, stability-based tuning of the PID controller.
[K0, Ki0, Kd0, Tf0, Wcg] = sbtuning (G, Mn, Ms);
C0 = pidctrl(K0,Ki0,Kd0,Tf0);
pidctrl(K0,Ki0,Kd0,Tf0);

params0 = [K0; Ki0; Kd0];

% Calculating the vector of relevant frequencies.
w = 0 : Wcg/2000 : 2*Wcg;

% Calculating the equidistant vector of relevant time instances.
[y, t]=step(feedback(minreal(C0*G), 1),0:0.001: t_end);
dt = t(2)-t(1);
t  = 0:dt:t(end);

% Optimization with filter dominant time constant set as Tf = Kd/Mn.
criteria = @(ksi) objfunc(G, H, ksi(1), ksi(2), ksi(3), ksi(3)/Mn, t, idx_type, Ms, w);
options = optimset('fmincon');
options = optimset(options, 'display', 'iter', 'TolX', 1e-8, 'TolFun', 1e-8, 'LargeScale', 'off');

% The initial parameters.
params = params0;

global Ms_target;
global G_sys;
global w_target;
global Mn_1;
global H_sys;

Ms_target = Ms;
G_sys = G;
w_target = w;
Mn_1 = Mn;
H_sys = H;

flag = 0;
options = optimset(options, 'MaxIter', 200);

while ~flag
        
    try
        [params, fval, flag] = fmincon(criteria, params, ...
            [], [], ...
            [], [], ...
            [0, 0, 0], [Inf, Inf, Inf], ...
            @constr, ...
            options);
    catch
        flag = 1;
        disp 'Exit due to an exception.'
    end
    
end

K  = params(1);
Ki = params(2);
Kd = params(3);
Tf = Kd/Mn;
C = pidctrl(K, Ki, Kd, Tf);

[Ms_result, SYS] = calcms(G, H, C, w);

fprintf('Resulting/Target Ms value : %d / %d\n', Ms_result, Ms);

Gf = minreal(G*SYS);
figure, step(Gf, t);
xlabel 'time'
ylabel 'response'
title 'Response to disturbance step signal'

Gr = minreal(C*Gf);
figure, step(tf([Ki],[1 0])*Gr/C, t);
xlabel 'time'
ylabel 'response'
title 'Response to reference step signal'

fprintf('Parameters: K=%d, Ki=%d, Kd=%d, Tf=%d\n', K, Ki, Kd, Tf);
%disp(sprintf('Optimality criteria: fval=%d', fval));



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE OPTIMALITY CRITERIA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function J = objfunc(G, H, K, Ki, Kd, Tf, t, idx, Ms, w)
% OBJFUNC   The objective function used in the optimization process of the algorithm.

C = pidctrl(K, Ki, Kd, Tf);
[Ms_current, SYS] = calcms(G, H, C, w);
e =step(minreal(SYS*G), t);

% The unconstrained optimality criteria
J = iecost(e, t, idx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function C = pidctrl(K, Ki, Kd, Tf)
% PIDCTRL   Calculates PID controller transfer function.
C = tf([Kd, K, Ki], [Tf, 1, 0]);

function [K, Ki, Kd, Tf, Wcg] = sbtuning(G, Mn, Ms)
% SBTUNING  Stability-based tuning method for real PID controllers.
[Gm, Pm, Wcg] = margin(G);
Tcg =2*pi/Wcg;
Tf  = Gm/(4*Ms*Mn);
Ki  =Tcg/2;
Kd  =Tcg/7;
K   =2.2*(Ms-1/Ms)*Gm/Tcg;
%Tf  =0.1; %Td/5;

Tf = 0.02601;
Kd = 0.8291;
Ki = 2.944;
K = 3.132;



function J = iecost(e, t, idx)
% IECOST    Calculates various optimality criteria.
%
% t parameter is assumed to be sampled equidistantly.
dt = t(2)-t(1);

switch idx
    case 1  % ISE
        J=e'*e*dt;
   
    case 2  % IAE
         J=sum(abs(e)*dt);
         %J1=sum(abs(e)*dt)
         %J=(sum(abs(e)*dt+(1-2*0.85)*e*dt))/2;
    case 3  % ITSE
        J=(t.*e'*dt)*e;
    case 4  % ITAE
        J=sum((t.^4)'.*abs(e)*dt);
        
end


function [Ms, SYS] = calcms(G, H, C, w)
% CALCMS    Calculates Ms parameter and related transfer function SYS using a set of relevant
% vectors w.
SYS = minreal(H/(1+G*C));
%SYS1 = minreal(G*C/(1+G*C));
[magS,~,~] = bode(SYS);
m(1, :) = magS(1, 1, :);
%m1 = bode(SYS1, w);
Ms = max(m);
%Mp = max(m1(:)):

function [cstr, ceq] = constr(params)
global Ms_target;
global G_sys;
global w_target;
global Mn_1;
global H_sys

K  = params(1);
Ki = params(2);
Kd = params(3);
Tf = Kd/Mn_1;
C = pidctrl(K, Ki, Kd, Tf);
Ms_current = calcms(G_sys, H_sys, C, w_target);
cstr = abs(Ms_current - Ms_target);
ceq=0;