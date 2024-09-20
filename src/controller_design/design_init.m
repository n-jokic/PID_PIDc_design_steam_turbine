    clc;
close all;
%Run init in src first!
%%
p = sym('s');
TW = sym('T_w', {'real', 'positive'});
TR = sym('T_r', {'real', 'positive'});
TT = sym('T_t', {'real', 'positive'});
C = sym('c', {'real', 'positive'});
KP = sym('K_p', {'real', 'positive'});
TP = sym('T_p', {'real', 'positive'});
TG = sym('T_g', {'real', 'positive'});
w = sym('w', {'real', 'positive'});

ns = sym('eta_s', {'real', 'positive'});
lam = sym('lambda', {'real', 'positive'});
N = sym('N', {'real', 'positive'});




if type == types{1}
    Gt = 1/(TT*p+1);
    gt = 1/(Tt*p + 1);
elseif type == types{2}
    Gt = (C*TR*p+1)/(TR*p+1)/(TT*p+1);
    gt = (c*Tr*p+1)/(Tr*p+1)/(Tt*p+1);

elseif type == types{3}
    Gt = (1-TW*p)/(1+0.5*TW*p);
    gt = (1-Tw*p)/(1+0.5*Tw*p);
end

Gp = KP/(TP*p+1);
gp = Kp/(Tp*p+1);
Gg = 1/(TG*p + 1);
gg = (1/(Tg*p + 1));

G = Gt*Gp*Gg;
g = gt*gp*gg;


