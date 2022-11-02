% Exercicio 1

%% 1.b)
fprintf('\n1.b)\n');
rates = [1500 1600 1700 1800 1900]; %pps
P = 100000;                         %stoping criteria
C = 10;                             %10Mbps
f = 1000000;                        %Bytes
N = 20;                             %times to simulate
b = 10^-4;                          %ber
alfa = 0.1;                         %90% confidence interval

APD_values = zeros(1, length(rates));
APD_terms = zeros(1, length(rates));
PL_values = zeros(1, length(rates));
PL_terms = zeros(1, length(rates));

PL = zeros(1, N);
APD = zeros(1, N);
MPD = zeros(1, N);
TT = zeros(1, N);

for i = 1:length(rates)
    for it = 1:N
            [PL(it), APD(it), MPD(it), TT(it)] = Simulator2(rates(i), C, f, P, b);
    end
    
    media = mean(APD);
    term = norminv(1-alfa/2)*sqrt(var(APD)/N);
    APD_values(i) = media;
    APD_terms(i) = term;

    media = mean(PL);
    term = norminv(1-alfa/2)*sqrt(var(PL)/N);
    PL_values(i) = media;
    PL_terms(i) = term;
end

figure(1);
hold on;
grid on;
bar(rates, APD_values');
er = errorbar(rates, APD_values', APD_terms);
er.Color = [0 0 0];
er.LineStyle = 'none';
xlabel('Packet Rate (pps)')
ylabel('Avg. Packet Delay (ms)')
title('Average Packet Delay vs Packet Rate');
hold off;

figure(2);
hold on;
grid on;
bar(rates, PL_values');
er = errorbar(rates, PL_values', PL_terms);
er.Color = [0 0 0];
er.LineStyle = 'none';
xlabel('Packet Rate (pps)')
ylabel('Packet Loss (%)')
title('Packet Loss vs Packet Rate');
hold off;

% packet loss aumenta devido ao ber
% nao percebo porque o ber diminui o packet loss