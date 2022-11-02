% Exercicio 1

%% 1.c)
f = 1000000;    %Packet Size in Bytes
b = 10^-6;
p_ber10e6 = (1 -(nchoosek(f*8, 0) * b^0 * (1-b)^(f*8))) * 100;
b = 10^-4;
p_ber10e4 = (1 - (nchoosek(f*8, 0) * b^0 * (1-b)^(f*8))) * 100;

fprintf(['Considering that the bit error rate is the only factor that can cause Packet to be lost, the theoretical packet loss (%%)\n ' ...
    'for a bit error rate of 10^-6 is: %f %%\n' ...
    'and for a bit error rate of 10^-4 is: %f %%'], p_ber10e6, p_ber10e4);