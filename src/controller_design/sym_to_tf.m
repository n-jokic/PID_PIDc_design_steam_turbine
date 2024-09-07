function transferf_expr = sym_to_tf(symbolic_expr)
    
    ExpFun = matlabFunction(symbolic_expr);
    ExpFun = str2func(regexprep(func2str(ExpFun), '\.([/^\\*])', '$1'));
    transferf_expr = tf(ExpFun(tf('s')));
  
end

