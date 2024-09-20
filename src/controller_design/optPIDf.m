function Qpid_optf = optPIDf(Ms, Mn, Q, G, Gp, p, s, R)
%Ms = 1.5;
%Mn = 120;
%Q = 1.1;

TF = sym('T_f', {'real', 'positive'});
K = sym('K', {'real', 'positive'});
KI = sym('K_i', {'real', 'positive'});
KD = sym('K_d', {'real', 'positive'});
wx = sym('w_x', {'real', 'positive'});
w = sym('w', {'real', 'positive'});
zeta = sym('zeta', {'real', 'positive'});

G_m = R*G/(R+G);

C = 1/(TF*p + 1)*(KI + KD*p^2 + K*p)/p;
C = subs(C, TF, KD/Mn);

C = (subs(C, p, 1i*w));
G_m = subs(G_m, p, 1i*w);
G_p = subs(Gp, p, 1i*w);

G_p = subs(G_p, KD, K^2/4/zeta^2/KI);
G_m = subs(G_m, KD, K^2/4/zeta^2/KI);
C = subs(C, KD, K^2/4/zeta^2/KI);

u = real(C*G_m);
v = imag(C*G_m);

fs = (1+u)^2 + v^2;
f1 = fs - 1/Ms^2; 
f2 = diff(fs, w);

u_m = real(G_p);
v_m = imag(G_p);

f3 = KI^2*(u_m^2 + v_m^2) - Q^2*fs*w^2;
f3 = subs(f3, w, wx);
f4 = subs(KI^2*(u_m^2 + v_m^2)/fs/w/w, w, wx);
f4 = diff(f4, wx);

%% Converting symbolic_eq to matlab functions:

f = [f1; f2; f3; f4];
f_opt = matlabFunction(f, 'Vars', {[K, KI, zeta, w, wx]});
objective = @(x) -x(3);

nonlincon = @(x) deal([], f_opt(x));

% Set the lower bounds for all variables to 0 (ensuring positivity)
lb = [0, 0, 0, 0, 0];  % Lower bound: all variables must be >= 0

% No upper bounds, so set ub to [] (no constraint on the upper bound)
ub = [3, 13, 1.1, 30, 30];  % No upper bounds

x0 = [2, 8, .4, 17, 17/2]/1.1;
% Set options for fmincon
options = optimoptions('fmincon', ...
    'Display', 'iter', ...               % Show progress during optimization
    'Algorithm', 'interior-point', ...              % Use SQP algorithm
    'MaxIterations', 2000, ...           % Increase the number of iterations
    'MaxFunctionEvaluations', 20000, ...  % Increase the number of function evaluations
    'FunctionTolerance', 1e-10, ...      % Tighten tolerance on the function value
    'StepTolerance', 1e-20, ...          % Tighten tolerance on the step size
    'ConstraintTolerance', 1e-12); 
[x_opt, ~] = fmincon(objective, x0, [], [], [], [], lb, ub, nonlincon, options);



%%
k = x_opt(1);
%kd = x_opt(2);
ki = x_opt(2);
z = x_opt(3);
kd = k^2/4/z^2/ki;
tf = kd/Mn;
Qpid_optf = 1/(tf*s + 1)/s*(ki + k*s + kd*s^2);

disp(x_opt)
end

