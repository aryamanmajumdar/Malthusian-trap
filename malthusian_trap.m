
%Simulating Malthusian growth with upper limit and consumption booms
%Aryaman Majumdar

%Call population N and log of population Y

N_init = 10;    %Initial population
N_upper = 100000; %Upper limit given the current income per capita. As of now, this is exogenous
Y_init = log(N_init);
Y_upper = log(N_upper);
r0 = 4; %Exponential growth rate
k = (Y_upper/Y_init)*(1/(Y_upper - Y_init))*r0;  %Constant needed in logarithmic function

t = 0:0.05:100;  %time
time_of_last_event = 0; %most recent time at which consumption per capita
                        %experienced an increase
time_since_event = 0;

n = numel(t);

test=0;

%Plot
figure
hold on
for i = 1:n

    time_since_event = t(i) - time_of_last_event;
    
    %The ln() of the population. The slope of this is the exponential growth rate r
    Y(i) = Y_upper/(1+(Y_upper/Y_init - 1)*exp(-k*time_since_event));
   
    Y(i) = normrnd(Y(i), 0.02*Y(i));
    if(test==1)
        disp("Y next");
        disp(Y(i));
    end
    %Some low chance of per capita increase because of more inputs or better production. 
    % Results in increase in growth rate r, which we encode in the variable
    % k
    X = rand;
    if(rand<0.001)
        time_of_last_event = t(i);
        Y_init = Y(i);
        Y_upper = Y_upper*1.6
        k = (Y_upper/Y_init)*(1/(Y_upper - Y_init))*r;
        disp("Y_initial");
        disp(Y_init);
        disp("Y");
        disp(Y(i));
        
        test=1;
    else
        test=0;
    end
    
    
    
    plot(t(1:i),Y(1:i))
    xlim([0 50])
    ylim([0 30])
    pause(0.0005)
    

end
