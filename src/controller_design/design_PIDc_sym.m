clc;

%% Controller setup:
ns = sym('eta_s', {'real', 'positive'});
lam = sym('lambda', {'real', 'positive'});
N = sym('N', {'real', 'positive'});
Pd = sym('P_d');

W = (ns*p+1)/(lam*s+1)/(lam\N*s+1)^3;

disp('W: ')
disp(latex(W));
disp('=============================================');



Fd = simplify(expand((1-W)))*Gp*Pd;
disp(Fd);


% solve(1-W), solve(num) daju pogresno resenje????

sol_ns = solve((lam*p + 1)*(lam/N*p+1)^3-(ns*p+1), ns, ...
    'ReturnConditions', true).eta_s;

disp('eta_s: ')
disp(latex(sol_ns));


sol_ns = simplify(subs(sol_ns, p, -1/TP));
[num, den] = numden(sol_ns);
disp(latex(collect(num)/den));
disp('=============================================');

Q = simplify(W/(1-W)/G);
disp('Q :');
disp(latex(Q));
disp('=============================================');

Q = simplify(subs(simplify(W/expand(1-W))/G, ns, sol_ns));