function Qpid_optf = optPIDf(Ms, Mn, Q, G, p, s, R)
%Ms = 1.5;
%Mn = 120;
%Q = 1.1;

TF = sym('T_f', {'real', 'positive'});
K = sym('K', {'real', 'positive'});
KI = sym('K_i', {'real', 'positive'});
KD = sym('K_d', {'real', 'positive'});
wx = sym('w_x', {'real', 'positive'});
w = sym('w', {'real', 'positive'});

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
ub = [5, 5, 5, 20, 10];  % No upper bounds

x0 = [2.052, .6947, 3.756/2, 6.3, 6.3/7]/1.1;
% Set options for fmincon
options = optimoptions('fmincon', ...
    'Display', 'iter', ...               % Show progress during optimization
    'Algorithm', 'Interior-point', ...              % Use SQP algorithm
    'MaxIterations', 10000, ...           % Increase the number of iterations
    'MaxFunctionEvaluations', 100000, ...  % Increase the number of function evaluations
    'FunctionTolerance', 1e-10, ...      % Tighten tolerance on the function value
    'StepTolerance', 1e-12, ...          % Tighten tolerance on the step size
    'ConstraintTolerance', 1e-12); 
[x_opt, ~] = fmincon(objective, x0, [], [], [], [], lb, ub, nonlincon, options);



%%
k = x_opt(1);
kd = x_opt(2);
ki = x_opt(3);
tf = kd/Mn;
Qpid_optf = 1/(tf*s + 1)/s*(ki + k*s + kd*s^2);

disp(x_opt)
end

