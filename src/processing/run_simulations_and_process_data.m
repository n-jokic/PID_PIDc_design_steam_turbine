
legend_names = {'PID_{c_1}', 'PID_{s_0= 0}', 'PID_{s_0=\lambda^{-1}}', ...
    'PID_{opt_t}'};

f1 = figure();
f1.Name = 'fm_comparison';

f2 = figure();
f2.Name = 'Pg_comparison';

[Q_num, Q_den] = tfdata(Qpidc - 1/R);
Q_num = Q_num{1};
Q_den = Q_den{1};

linewidth = 1;
colour = 'b';
style = ':';
out_pidc = sim('plant_model_fbl');


[IAE, IE, ITAE, TVd] = process_sim_data(...
    f1,f2, out_pidc, linewidth, colour, style, td, t1, t2);

disp('Q_pidc data: ');
disp([IAE, IE, ITAE, TVd]);
disp('===================================');


[Q_num, Q_den] = tfdata(Qpid - 1/R);
Q_num = Q_num{1};
Q_den = Q_den{1};

linewidth = 1;
colour = 'r';
style = '--';

out_pid = sim('plant_model_fbl');
[IAE, IE, ITAE, TVd] = process_sim_data(...
    f1,f2, out_pid, linewidth, colour, style, td, t1, t2);

disp('Q_pid data: ');
disp([IAE, IE, ITAE, TVd]);
disp('===================================');



[Q_num, Q_den] = tfdata(Qpid_lam - 1/R);
Q_num = Q_num{1};
Q_den = Q_den{1};

linewidth = 1;
colour = 'k';
style = '-.';

out_pid_lam = sim('plant_model_fbl');
[IAE, IE, ITAE, TVd] = process_sim_data(...
    f1,f2, out_pid_lam, linewidth, colour, style, td, t1, t2);

disp('Q_pid_lam data: ');
disp([IAE, IE, ITAE, TVd]);
disp('===================================');


[Q_num, Q_den] = tfdata(Qpid_opt);
Q_num = Q_num{1};
Q_den = Q_den{1};

linewidth = 1;
colour = 'm';
style = ':';
out_pid_opt = sim('plant_model_fbl');
[IAE, IE, ITAE, TVd] = process_sim_data(...
    f1,f2, out_pid_opt, linewidth, colour, style, td, t1, t2);

disp('Q_pid_opt data: ');
disp([IAE, IE, ITAE, TVd]);
disp('===================================');

figure(f1);
legend(legend_names, 'Location', 'best');
figure(f2);
legend(legend_names, 'Location', 'best');

if SAVE_PLOTS
    save_plots([f1, f2], {[f1.Name '_' id], ...
        [f2.Name '_' id]}, PATH)
end

