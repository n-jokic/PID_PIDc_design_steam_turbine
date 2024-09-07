if ~exist('selector', 'var')
    init;
end
%%
n = 20;
lambda = 0.6;
expansion_point = 0;
Mn = 120;

Qpidc = create_symbolic_PIDc(Gt);
Qpid = create_symbolic_PID(Gt, expansion_point, Mn, R);
%%
if type == types{1}
    
    % param subs
    Qpid = subs(Qpid, KP, Kp);
    Qpid = subs(Qpid, TP, Tp);
    Qpid = subs(Qpid, TT, Tt);
    Qpid = subs(Qpid, TG, Tg);
    Qpid = subs(Qpid, lam, lambda);
    Qpid = subs(Qpid, N, n);
    
    %conversion to tf
    Qpid = sym_to_tf(Qpid);

    % param subs
    Qpidc = subs(Qpidc, KP, Kp);
    Qpidc = subs(Qpidc, TP, Tp);
    Qpidc = subs(Qpidc, TT, Tt);
    Qpidc = subs(Qpidc, TG, Tg);
    Qpidc = subs(Qpidc, lam, lambda);
    Qpidc = subs(Qpidc, N, n);
    
    %conversion to tf
    Qpidc = sym_to_tf(Qpidc);


  

elseif type == types{2}

    % param subs
    Qpid = subs(Qpid, KP, Kp);
    Qpid = subs(Qpid, TP, Tp);
    Qpid = subs(Qpid, TT, Tt);
    Qpid = subs(Qpid, TG, Tg);
    Qpid = subs(Qpid, TR, Tr);
    Qpid = subs(Qpid, C, c);
    Qpid = subs(Qpid, lam, lambda);
    Qpid = subs(Qpid, N, n);
    
    %conversion to tf
    Qpid = sym_to_tf(Qpid);

    % param subs
    Qpidc = subs(Qpidc, KP, Kp);
    Qpidc = subs(Qpidc, TP, Tp);
    Qpidc = subs(Qpidc, TT, Tt);
    Qpidc = subs(Qpidc, TG, Tg);
    Qpidc = subs(Qpidc, TR, Tr);
    Qpidc = subs(Qpidc, C, c);
    Qpidc = subs(Qpidc, lam, lambda);
    Qpidc = subs(Qpidc, N, n);
    
    %conversion to tf
    Qpidc = sym_to_tf(Qpidc);

   

elseif type == types{3}
    
    % param subs
    Qpid = subs(Qpid, KP, Kp);
    Qpid = subs(Qpid, TP, Tp);
    Qpid = subs(Qpid, TW, Tw);
    Qpid = subs(Qpid, TG, Tg);
    Qpid = subs(Qpid, lam, lambda);
    Qpid = subs(Qpid, N, n);
    
    %conversion to tf
    Qpid = sym_to_tf(Qpid);

    % param subs
    Qpidc = subs(Qpidc, KP, Kp);
    Qpidc = subs(Qpidc, TP, Tp);
    Qpidc = subs(Qpidc, TW, Tw);
    Qpidc = subs(Qpidc, TG, Tg);
    Qpidc = subs(Qpidc, lam, lambda);
    Qpidc = subs(Qpidc, N, n);
    
    %conversion to tf
    Qpidc = sym_to_tf(Qpidc);
end

