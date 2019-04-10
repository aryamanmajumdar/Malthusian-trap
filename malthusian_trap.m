
%Simulating Malthusian growth with upper limit and consumption booms
%Aryaman Majumdar

%Call population N
%V3: Adding consumption per capita c.
%Consumption C = z*F(L,N) = z*(L^0.6)*(N^0.4)
%Consumption per capita c = z*F(L,N)/N = z*f(l) = z*(l^0.6)

z = 200000; %Total factor productivity. The fact that it's 200000 is just a scaling thing.

N_init = 100000;  %Initially, the starting and final populations are the same because there's no steady state growth
N_upper = 100000;
N(i) = N_init;

L0 = 100; %Don't know units yet
L_new = L0;
L(i) = L0;

c(i) = z*(L0/N(i))^0.6;

r0 = 0.09; %Exponential growth rate

t = 0:0.1:200;  %time
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
    N(i) = N_upper/(1+(N_upper/N_init - 1)*exp(-r0*time_since_event));
    L(i) = L_new;
    c(i) = z*(L(i)/N(i))^0.6;
    
    c(i) = normrnd(c(i), 0.0002*c(i));
    N(i) = normrnd(N(i), 0.002*N(i));

    %Some low chance of per capita increase because of more inputs or better production. 
    % Right now, c increases only because of an increase in L
    X = rand;
    if(rand<0.0022)
        time_of_last_event = t(i);
        
        L_new = L(i)*1.05;
        
        
        N_init = N(i);
        N_upper = N_upper*(L_new/L(i)); %This is the thing I'm unsure of

        test=1;
    else
        test=0;
    end
    
    
    figure(1)
    plot(t(1:i),c(1:i))
    xlim([0 200])
    ylim([3000 3500])
    pause(0.008)
    
    figure(2)
    plot(t(1:i),N(1:i))
    xlim([0 200])
    ylim([80000 200000])
    pause(0.004)

end
