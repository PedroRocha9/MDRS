% Exercicio 2

%% 2.a)
rate = 1500;                %pps
P = 100000;                 %stoping criteria
C = 10;                     %10Mbps
f = 1000000;                %Bytes
N = 20;                     %times to simulate
nVoips = [10 20 30 40];     %nr voip packets
b = 10^-5;                  %bit error rate
alfa = 0.1;                 %90% confidence interval

PLd_values = zeros(1, length(nVoips));
PLd_terms = zeros(1, length(nVoips));
PLv_values = zeros(1, length(nVoips));
PLv_terms = zeros(1, length(nVoips));
APDd_values = zeros(1, length(nVoips));
APDd_terms = zeros(1, length(nVoips));
APDv_values = zeros(1, length(nVoips));
APDv_terms = zeros(1, length(nVoips));

PLd = zeros(1, N);
PLv = zeros(1, N);
APDd = zeros(1, N);
APDv = zeros(1, N);
MPDd = zeros(1, N);
MPDv = zeros(1, N);
TT = zeros(1, N);

for i = 1 : length(nVoips)
    for it = 1:N
        [PLd(it), PLv(it), APDd(it), APDv(it), MPDd(it), MPDv(it), TT(it)] = Simulator3A(rate, C, f, P, nVoips(1), b);
    end

    media = mean(PLd);
    term = norminv(1-alfa/2)*sqrt(var(PLd)/N);
    PLd_values(i) = media;
    PLd_terms(i) = term;

    media = mean(PLv);
    term = norminv(1-alfa/2)*sqrt(var(PLv)/N);
    PLv_values(i) = media;
    PLv_terms(i) = term;

    media = mean(APDd);
    term = norminv(1-alfa/2)*sqrt(var(APDd)/N);
    APDd_values(i) = media;
    APDd_terms(i) = term;

    media = mean(APDv);
    term = norminv(1-alfa/2)*sqrt(var(APDv)/N);
    APDv_values(i) = media;
    APDv_terms(i) = term;
end

figure(1);
hold on;
grid on;
bar(nVoips, PLd_values');
er = errorbar(nVoips, PLd_values', PLd_terms);
er.Color = [0 0 0];
er.LineStyle = 'none';
xlabel('Number of VoIP Packets')
ylabel('Avg. Data Packet Loss (%)')
title('Avg. Data Packet Loss vs Number of VoIP Packets');
hold off;

figure(2);
hold on;
grid on;
bar(nVoips, APDd_values');
er = errorbar(nVoips, APDd_values', APDd_terms);
er.Color = [0 0 0];
er.LineStyle = 'none';
xlabel('Number of VoIP Packets')
ylabel('Avg. Data Packet Delay (s)')
title('Average Data Packet Delay vs Number of VoIP Packets');
hold off;

figure(3);
hold on;
bar(nVoips, PLv_values');
er = errorbar(nVoips, PLv_values', PLv_terms);
er.Color = [0 0 0];
er.LineStyle = 'none';
xlabel('Number of VoIP Packets')
ylabel('Avg. VoIP Packet Loss (%)')
title('Avg. VoIP Packet Loss vs Number of VoIP Packets');
hold off;

figure(4);
hold on;
bar(nVoips, APDv_values');
er = errorbar(nVoips, APDv_values', APDv_terms);
er.Color = [0 0 0];
er.LineStyle = 'none';
xlabel('Number of VoIP Packets')
ylabel('Avg. VoIP Packet Delay (s)')
title('Average VoIP Packet Delay vs Number of VoIP Packets');
hold off;

% menos delay e menor loss no VoIP porque tem maior prioridade