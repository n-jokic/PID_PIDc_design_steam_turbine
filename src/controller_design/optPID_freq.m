Ms = 1.5;
Mn = 120;
Q = 1.1;

TF = sym('T_f', {'real', 'positive'});
K = sym('K', {'real', 'positive'});
KI = sym('K_i', {'real', 'positive'});
KD = sym('K_d', {'real', 'positive'});
wx = sym('w_x', {'real', 'positive'});
%%
if type == types{1}
    Gt = 1/(Tt*p+1);
elseif type == types{2}
    Gt = (c*Tr*p+1)/(Tr*p+1)/(Tt*p+1);
elseif type == types{3}
    Gt = (1-Tw*p)/(1+0.5*Tw*p);
end

Gp = Kp/(Tp*p+1);
Gg = 1/(Tg*p + 1);

G = vpa(Gt*Gp*Gg, 3);
G_m = simplify(G/(1+G/R));

[N,D] = numden(G_m);
Dc = coeffs(D,p);
NN = N/Dc(end);
ND = D/Dc(end);
G_m = vpa(NN/ND, 5);

C = 1/(TF*p + 1)*(KI + KD*p^2 + K*p)/p;
C = subs(C, TF, KD/Mn);

C = vpa((subs(C, p, 1i*w)), 5);
G_m = vpa(subs(G_m, p, 1i*w), 5);

u = vpa(real(C*G_m), 3);
v = vpa(imag(C*G_m), 3);


f1 = vpa((1+u)^2 + v^2 - 1/Ms^2, 5); 
f2 = vpa(diff(f1, w), 5);

u_m = vpa(real(G_m), 5);
v_m = vpa(imag(G_m), 5);

f3 = (u_m^2 + v_m^2)- Q^2*(u^2 + v^2);
f3 = vpa(subs(f3, w, wx), 5);
f4 = subs(sqrt((u_m^2 + v_m^2)/(u^2 + v^2)), w, wx);
f4 = vpa(diff(f4, wx), 5);

%% Converting symbolic_eq to matlab functions:

f = [f1; f2; f3; f4];
f_opt = matlabFunction(f, 'Vars', {[K, KD, KI, w, wx]});
objective = @(x) -x(1);

nonlincon = @(x) deal([], f_opt(x));

% Set the lower bounds for all variables to 0 (ensuring positivity)
lb = [0, 0, 0, 0, 0];  % Lower bound: all variables must be >= 0

% No upper bounds, so set ub to [] (no constraint on the upper bound)
ub = [5, 5, 5, 10, 10]*2;  % No upper bounds

x0 = [2, .8, 3, 2, 2];
% Set options for fmincon
options = optimoptions('fmincon', ...
    'Display', 'iter', ...               % Show progress during optimization
    'Algorithm', 'sqp', ...              % Use SQP algorithm
    'MaxIterations', 1000, ...           % Increase the number of iterations
    'MaxFunctionEvaluations', 50000, ...  % Increase the number of function evaluations
    'FunctionTolerance', 1e-10, ...      % Tighten tolerance on the function value
    'StepTolerance', 1e-12, ...          % Tighten tolerance on the step size
    'ConstraintTolerance', 1e-12); 
[x_opt, fval] = fmincon(objective, x0, [], [], [], [], lb, ub, nonlincon, options);

%%
k = x_opt(1);
kd = x_opt(2);
ki = x_opt(3);
tf = kd/Mn;

cpid= 1/(tf*s+1)*(k*s + kd*s^2 + ki)/s;

f = figure();
f.Name = 'Ms_Mt_pid_opt';
C = cpid;  
H = 1;
find_Ms_Mt(Gm/(1+Gm/R), H, C, true);

