clear variables;
close all;
clc;

%all subfolders to path
addpath(genpath(pwd));

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
    R = 0.05;

end

s = tf('s');

Gm = 1/(Tg*s+1)*Kp/(Tp*s+1)*(1+(-Tw+c*Tr)*s)/(1+(Tr+Tt+0.5*Tw)*s+Tt*Tr*s);
Gp = 1/(1+(-Tw+c*Tr)*s)/(1+(Tr+Tt+0.5*Tw)*s+Tt*Tr*s);
%% Simulation setup:
% step signals
td = 1; 
d = -1;

tr = 0;
r = 0;


% noise
sigma_n = 0;
Q_num = [0];
Q_den = [1 1];

t_end = 10;
%% Controller design init
design_init;

%% Save setup
SAVE_PLOTS = false;
PATH = '..\latex\slike';

