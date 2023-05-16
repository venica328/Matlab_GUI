% Vytvorenie 2sigma tunelu; zo 100 hodnoôt procesu vypočítame strednú
% hodnotu a odchylku. Zisťujeme, či 101 hodnota patrí do interválu 
% I = <str.hodnota - 2*odchylka, str.hodnota + 2*odchylka> 
% Posúvame okno vždy o jedna a prepočítavame hodnoty nanovo.

function tunel = dve_sigmy(data,dlzkaOkna,zaciatok,vystup,sigma)
    
    pocetPredikovanych = vystup - dlzkaOkna;

    % tvorba tunelu
    u = data(zaciatok: zaciatok + dlzkaOkna + pocetPredikovanych - 1);
    tunel = zeros(2, vystup - dlzkaOkna);
    
    for t = 1: pocetPredikovanych
        radNaPredikciu = u(t: t + dlzkaOkna - 1);
        so = std(radNaPredikciu);
        sh = mean(radNaPredikciu);
        tunel(1, t) = sh + sigma*so;
        tunel(2, t) = sh - sigma*so;
    end
end
