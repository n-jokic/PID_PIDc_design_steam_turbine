function  [Ms, inS, amS, Mt, inT, amT, wout] = find_Ms_Mt(G, H, C, draw_plot)
S = minreal(H/(1+C*G));
T = 1-S;
if ~exist("draw_plot", 'var')
    draw_plot = false;
end

[magT,~,wout] = bode(T);
[magS,~,~] = bode(S, wout);

amT(1, :) = magT(1,1, :);
amS(1, :) = magS(1, 1, :);

[Mt, inT] = max(amT);
[Ms, inS] = max(amS);
pos = round((1 + length(wout))/2);

if draw_plot
figure(gcf);

    p1 = semilogx(wout, amT, 'black');
    hold on;
    p2 = semilogx(wout, amS, 'red--');
        xlabel('log(\omega) [rad/s]');
        ylabel('A(\omega)');
        grid on;
    semilogx(wout(inT), Mt, 'b*');
    semilogx(wout(inS), Ms, 'b*');
        legend([p1, p2], {'T', 'S'});
        text(wout(round((pos/2))), 1.2, {['Ms = ' num2str(round(Ms, 3))], ...
        ['Mt = ' num2str(round(Mt, 3))]}, ...
        'Interpreter', 'latex');
end

end