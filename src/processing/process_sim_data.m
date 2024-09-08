 function  [IAE, IE, ITAE, TVd] = process_sim_data(...
    fig1,fig2, out, linewidth, colour,style, td, t1, t2)
t = out.simdata.Time;
u = out.simdata.Data(:, 3);
Pg = out.simdata.Data(:, 2);
fm = out.simdata.Data(:, 3);

ind_td = find(t >= td, 1, 'first');

ind_t1 = find(t >= t1, 1, 'first');
ind_t2 = find(t >= t2, 1, 'first');
slice = ind_t1:ind_t2;

figure(fig1);
    hold all;
    plot(t(slice), fm(slice), 'LineWidth', linewidth ,'Color' , colour, ...
        'LineStyle', style);
    xlim([t(ind_t1), t(ind_t2)]);
    grid on;

figure(fig2);
hold all;
    plot(t(slice), Pg(slice), 'LineWidth', linewidth ,'Color' , colour, ...
        'LineStyle', style);
    xlim([t(ind_t1), t(ind_t2)]);
    grid on;


IAE = sum(abs(fm(ind_td:end)));
IE = sum(fm(ind_td:end));
ITAE = sum(t(ind_td:end).*abs(fm(ind_td:end)));

u_i = [u(ind_td+1:end); u(end)];
u_i_1 = u(ind_td:end);
TVd = sum(abs(u_i-u_i_1));
end

