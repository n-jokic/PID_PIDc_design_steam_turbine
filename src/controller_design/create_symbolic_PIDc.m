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

sol_ns = solve((lam*p + 1)*(lam/N*p+1)^3-(ns*p+1), ns, ...
    'ReturnConditions', true).eta_s;

Q = simplify(subs(simplify(W/expand(1-W))/G, ns, sol_ns));
end

