if ~exist('selector', 'var')
    init;
end
close all;
%%
n = 20;
lambda = 0.6;
expansion_point = 0;
Mn = 120;
Ms = 2;

Qpidc = create_symbolic_PIDc(Gt);
Qpid = create_symbolic_PID(Gt, expansion_point, Mn, R);
Qpid_lam = create_symbolic_PID(Gt, 1/lambda, Mn, R);
answer = otPID(minreal(Gm/(1+Gm/R)), Gp, Mn, Ms, 4, 4);
Qpid_opt = answer;
convert_all_to_tf;

%%
close all;
Ms =2;
Q = 1.028;
Qpid_optf = optPIDf(Ms, Mn, Q, g, gp, p, s, R, .33);

f = figure();
f.Name = 'Ms_Mt_pid_optf';
C = Qpid_optf;  
H = 1;
find_Ms_Mt(feedback(Gm, 1/R), H, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end

disp(Qpid_optf.Numerator)
disp(Qpid_opt.Numerator)

figure, step(-minreal(Gp/(1+feedback(Gm, 1/R)*Qpid_opt)))
hold on;
step(-minreal(Gp/(1+feedback(Gm, 1/R)*Qpid_optf)), 'k--')


figure, bode(minreal(Gp/(1+feedback(Gm, 1/R)*Qpid_opt)))
hold on, bode(minreal(Gp/(1+feedback(Gm, 1/R)*Qpid_optf)))


%% Мs/Mt: 
f = figure();
f.Name = 'Ms_Mt_pidc';
C = Qpidc;  
H = 1+Gm/R;
find_Ms_Mt(Gm, H, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end

f = figure();
f.Name = 'Ms_Mt_pid';
C = Qpid; 
find_Ms_Mt(Gm, H, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end


f = figure();
f.Name = 'Ms_Mt_pid_lam';
C = Qpid_lam;  
find_Ms_Mt(Gm, H, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end

f = figure();
f.Name = 'Ms_Mt_pid_opt';
C = Qpid_opt;  
H = 1;
find_Ms_Mt(feedback(Gm, 1/R), H, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end



%%

id = 'default';
sigma_n = 0;
t1 = 0.9;
t2 = 5;
run_simulations_and_process_data;

%% robustness: 
Tt_normal = Tt;
Tp_normal = Tp;
Tg_normal = Tg;
Kp_normal = Kp;

id = '+50';

scale = 1.5;
Tt = scale*Tt_normal;
Tp = scale*Tp_normal;
Tg = scale*Tg_normal;
Kp = scale*Kp_normal;
run_simulations_and_process_data;

id = '-50';

scale = 0.5;
Tt = scale*Tt_normal;
Tp = scale*Tp_normal;
Tg = scale*Tg_normal;
Kp = scale*Kp_normal;
run_simulations_and_process_data;

scale = 1;
Tt = scale*Tt_normal;
Tp = scale*Tp_normal;
Tg = scale*Tg_normal;
Kp = scale*Kp_normal;

%% with noise: 
sigma_n = 0.001;
id = 'noise';
run_simulations_and_process_data;
