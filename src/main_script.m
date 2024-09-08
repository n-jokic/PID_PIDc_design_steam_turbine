if ~exist('selector', 'var')
    init;
end
close all;
%%
n = 20;
lambda = 0.6;
expansion_point = 0;
Mn = 120;

Qpidc = create_symbolic_PIDc(Gt);
Qpid = create_symbolic_PID(Gt, expansion_point, Mn, R);
Qpid_lam = create_symbolic_PID(Gt, 1.5/lambda, Mn, R);
%%
convert_all_to_tf;
%% Мs/Mt: 
f = figure();
f.Name = 'Ms_Mt_pidc';
C = Qpidc-1/R;  
find_Ms_Mt(Gm, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end

f = figure();
f.Name = 'Ms_Mt_pid';
C = Qpid-1/R;  
find_Ms_Mt(Gm, C, true);

if SAVE_PLOTS
    save_plots(f, {f.Name}, PATH)
end


f = figure();
f.Name = 'Ms_Mt_pid_lam';
C = Qpid_lam-1/R;  
find_Ms_Mt(Gm, C, true);

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
