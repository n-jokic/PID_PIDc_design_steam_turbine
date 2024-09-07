function Q_pid = create_symbolic_PID(Gt, expansion_point, Mn, R)
p = sym('s');

Q = create_symbolic_PIDc(Gt);

TF = sym('T_f', {'real', 'positive'});


f3 = taylor(p*(TF*p+1)*Q,p,'ExpansionPoint', expansion_point, 'order',3);
coeff_list = coeffs(f3, p);

Tf = coeff_list(2)/(Mn + 1/R);
Tf = solve(Tf-TF, TF, 'ReturnConditions', true).T_f;

Q_pid = f3/(p*(TF*p+1));
Q_pid = subs(Q_pid, TF, Tf);

end

