if type == types{1}
    
    % param subs
    Qpid = subs(Qpid, KP, Kp);
    Qpid = subs(Qpid, TP, Tp);
    Qpid = subs(Qpid, TT, Tt);
    Qpid = subs(Qpid, TG, Tg);
    Qpid = subs(Qpid, lam, lambda);
    Qpid = subs(Qpid, N, n);

    Qpid_lam = subs(Qpid_lam, KP, Kp);
    Qpid_lam = subs(Qpid_lam, TP, Tp);
    Qpid_lam = subs(Qpid_lam, TT, Tt);
    Qpid_lam = subs(Qpid_lam, TG, Tg);
    Qpid_lam = subs(Qpid_lam, lam, lambda);
    Qpid_lam = subs(Qpid_lam, N, n);
    
    %conversion to tf
    Qpid = sym_to_tf(Qpid);

    Qpid_lam = sym_to_tf(Qpid_lam);

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
    
    Qpid_lam = subs(Qpid_lam, KP, Kp);
    Qpid_lam = subs(Qpid_lam, TP, Tp);
    Qpid_lam = subs(Qpid_lam, TT, Tt);
    Qpid_lam = subs(Qpid_lam, TG, Tg);
    Qpid_lam = subs(Qpid_lam, TR, Tr);
    Qpid_lam = subs(Qpid_lam, C, c);
    Qpid_lam = subs(Qpid_lam, lam, lambda);
    Qpid_lam = subs(Qpid_lam, N, n);
    
    %conversion to tf
    Qpid = sym_to_tf(Qpid);

    Qpid_lam = sym_to_tf(Qpid_lam);


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
    
    Qpid_lam = subs(Qpid_lam, KP, Kp);
    Qpid_lam = subs(Qpid_lam, TP, Tp);
    Qpid_lam = subs(Qpid_lam, TW, Tw);
    Qpid_lam = subs(Qpid_lam, TG, Tg);
    Qpid_lam = subs(Qpid_lam, lam, lambda);
    Qpid_lam = subs(Qpid_lam, N, n);
    
    %conversion to tf
    Qpid = sym_to_tf(Qpid);

    Qpid_lam = sym_to_tf(Qpid_lam);

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
