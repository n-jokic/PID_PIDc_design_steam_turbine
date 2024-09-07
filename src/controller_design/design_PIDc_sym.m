clc;

%% Controller setup:
ns = sym('eta_s', {'real', 'positive'});
lam = sym('lambda', {'real', 'positive'});
N = sym('N', {'real', 'positive'});
Pd = sym('P_d');

W = (ns*p+1)/(lam*p+1)/(lam/N*p+1)^3;

disp('W: ')
disp(latex(W));
disp('=============================================');



Fd = simplify(expand((1-W)))*Gp*Pd;
disp(Fd);


% solve(1-W), solve(num) daju pogresno resenje????

sol_ns = solve(1-W, ns, ...
    'ReturnConditions', true).eta_s;

disp('eta_s: ')
disp(latex(sol_ns));


sol_ns = simplify(subs(sol_ns, p, -1/TP));
[num, den] = numden(sol_ns);
disp(latex(collect(num)/den));
disp('=============================================');

Q = simplify(W/G/(1-W), 'IgnoreAnalyticConstraints', true, 'Steps', 10);

disp('Q :');
disp(latex(Q));
disp('=============================================');

Q = simplify(subs(simplify(W/expand(1-W))/G, ns, sol_ns), 'IgnoreAnalyticConstraints', true, 'Steps', 10);