if exist('Q', 'var')
    if class(Q) ~= "sym"
        design_PIDc_sym;
    end
else
    design_PIDc_sym;
end

clc;

%% 



TF = sym('T_f', {'real', 'positive'});

f3 = taylor(p*(TF*p+1)*Q,p,'ExpansionPoint', 0, 'order',3);
coeff_list = coeffs(f3, p);

Tf = coeff_list(2)/(120+1/2.4);

disp('Q_pid :');
disp(latex(Q_pid));
disp('=============================================');

