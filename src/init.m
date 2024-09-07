clear variables;
close all;
clc;

%% Parameters:
types = {'non-reheated', 'reheated', 'hydro'};

selector = 1;
type = types{selector}; 

% setting all model params to 0 for model
Kp = 0;
Tp = 0;
Tt = 0;
Tg = 0;
R = 0;
Tr = 0;
c = 0;
Tw = 0;

if type == types{1}

    Kp = 120;
    Tp = 20;
    Tt = 0.3;
    Tg = 0.08;
    R = 2.4;

elseif type == types{2}
    
    Kp = 120;
    Tp = 20;
    Tt = 0.3;
    Tg = 0.08;
    R = 2.4;
    Tr = 4.2;
    c = 0.35;

elseif type == types{3}

    Kp = 1;
    Tp = 6;
    Tw = 4;
    Tg = 0.2;

end

%% Simulation setup:
% step signals
td = 0; 
d = 0;

tr = 0;
r = 0;


% noise
sigma_n = 0;
Q_num = [0];
Q_den = [1 1];
