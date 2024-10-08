function Q = create_symbolic_PIDc(Gt)

p = sym('s');
KP = sym('K_p', {'real', 'positive'});
TP = sym('T_p', {'real', 'positive'});
TG = sym('T_g', {'real', 'positive'});

Gp = KP/(TP*p+1);
Gg = 1/(TG*p + 1);
G = Gt*Gp*Gg;


ns = sym('eta_s', {'real', 'positive'});
lam = sym('lambda', {'real', 'positive'});
N = sym('N', {'real', 'positive'});


W = (ns*p+1)/(lam*p+1)/(lam/N*p+1)^3;

sol_ns = solve(1-W, ns, ...
    'ReturnConditions', true).eta_s;



sol_ns = simplify(subs(sol_ns, p, -1/TP));
[num, den] = numden(sol_ns);
sol_ns  = collect(num)/den;


Q = simplify(subs(W/(1-W)/G, ns, sol_ns), ...
    'IgnoreAnalyticConstraints', true, 'Steps', 10);
end

