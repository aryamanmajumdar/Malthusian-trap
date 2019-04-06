
%Simulating Malthusian growth
%Aryaman Majumdar

N_init = 10;    %Initial population
N_upper = 100000; %Upper limit given the current income per capita. As of now, this is exogenous

t = 0:0.01:100;  %time


n = numel(t);

%Plot
figure
hold on
for i = 1:n

    %The ln() of the population. The slope of this is the exponential growth rate r
    N(i) = log(N_upper)/(1+(log(N_upper)/log(N_init) - 1)*exp(-0.5*t(i)));
    
    %Some low chance of per capita increase because of more inputs or better production. 
    % Doesn't result in the growth rate changing quite the right way, but it'll do for now.
    X = rand;
    if(rand<0.0008)
        N_upper = N_upper*2;
    end
    
    plot(t(1:i),N(1:i))
    xlim([0 50])
    ylim([0 30])
    pause(0.0005)
end
