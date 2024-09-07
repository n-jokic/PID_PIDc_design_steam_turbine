%% Model setup:
p = sym('s');
TW = sym('T_w', {'real', 'positive'});
TR = sym('T_r', {'real', 'positive'});
TT = sym('T_t', {'real', 'positive'});
C = sym('c', {'real', 'positive'});
KP = sym('K_p', {'real', 'positive'});
TP = sym('T_p', {'real', 'positive'});
TG = sym('T_g', {'real', 'positive'});
w = sym('w', {'real', 'positive'});




if type == types{1}
    Gt = 1/(TT*p+1);
elseif type == types{2}
    Gt = (C*TR*p+1)/(TR*p+1)/(TT*p+1);
elseif type == types{3}
    Gt = (1-TW*p)/(1+0.5*TW*p);
end

Gp = KP/(TP*p+1);
Gg = 1/(TG*p + 1);

G = Gt*Gp*Gg;

display(G);

%% Controller setup:
ns = sym('eta_s', {'real', 'positive'});
lam = sym('lambda', {'real', 'positive'});
N = sym('N', {'real', 'positive'});
Pd = sym('P_d');

W = (ns*p+1)/(lam*s+1)/(lam\N*s+1)^3;
disp(W);

Fd = simplify(expand((1-W)))*Gp*Pd;
disp(Fd);

sol_ns = solve(Fd, ns);
disp(sol_ns);

sol_ns = subs(sol_ns, p, -1/Tp);
disp(sol_ns);

Q = simplify(subs(simplify(W/expand(1-W))/G, ns, sol_ns));
disp(Q);