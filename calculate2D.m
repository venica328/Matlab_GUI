
function v = calculate2D(data,okno,func_param,method)

v = 0;
Nt = data;
N = length(Nt);

    % 1-parametricke metody
    if method == 1

        for i=1:N-okno
           data  = Nt(i:okno-1+i);
           if func_param == 1
                v(i)  = mean(data); % klzavy priemer 
           elseif func_param == 2
                v(i)  = sqrt(cov(data)); % smerodajna odchylka
           elseif func_param == 3
                v(i) = sqrt(cov(data))/mean(data); % koeficient variabilnosti
           elseif func_param == 4
                v(i)  = kurtosis(data); % sikmost
           elseif func_param == 5
                v(i) = max(skewness(data),0); % spicatost
           elseif func_param == 6
                v(i) = hurst(data); % Hurstov exponent
            elseif func_param == 61
                v(i) = Hurst_RS(data,0,0,0); % Hurstov exponent RS
            elseif func_param == 62
                v(i) = DFA(data,2,0); % Hurstov exponent DFA
            elseif func_param == 63
                v(i) = AbsoluteMethod(data,2,0); % Hurstov exponent Abs
           elseif func_param == 7
                v(i) = Ent(data);   % pre vypocet Entropie
           elseif func_param == 8
                m(i)  = mean(data); % klzavy priemer 
                d0 = data - m(i); % centrovane data 
                v(i) = d0*d0'./okno; % energia centrovanych dat
           end   
        end

    % 2-parametricke metody
    elseif method == 2

         for i=1:N-okno-1
             x1 = Nt(i:okno-1+i);
             x2 = Nt(i+1:okno-1+i+1);
             if func_param == 9
                v(i) = (x2*x1')/(x1*x1');% autoregresia
             elseif func_param == 10
                Ro =  corrcoef(x1,x2); 
                v(i) = Ro(1,2);  % korelacny koeficient
             elseif func_param == 11
                v(i) = max(Diverg(x1,x2),0);  % divergencia
             end
         end
     end
end