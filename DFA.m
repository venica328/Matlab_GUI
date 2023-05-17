function HURST = DFA(data, regresion, is_plot)
    f = data;
    DFA = [];
    DFAN = [];
    K = length(f);

    for k = 2:K %pocet okien
        n = K/k; % velkost okna
        if n < 10
            break
        end
        if mod(K,k) == 0
            index = 1;
            SSn = [];
            for i = 0:n:K-1
                if i == 0
                    cr = i+1:i+n;
                else
                    cr = i:i+n;
                end

                Y = cumsum(f(cr));
                if regresion == 3
                    
                    b0 = ones(1,length(Y));
                    b1 = 1:length(Y);
                    b2 = (1:length(Y)).^2;
                    b3 = (1:length(Y)).^3;
                    %{
                    b = [Y*b0' 
                        Y*(b1)'
                        Y*(b2)'
                        Y*(b3)'];
    
                    A = [ b0*b0' b0*b1' b0*b2' b0*b3'
                          b1*b0' b1*b1' b1*b2' b1*b3'
                          b2*b0' b2*b1' b2*b2' b2*b3'
                          b3*b0' b3*b1' b3*b2' b3*b3'];
                    
                    c = pinv(A)*b;
                    %}
                    c = polyfit(1:length(Y), Y, 3);
                    YY = b3*c(1) + b2*c(2) + b1*c(3) + c(4);
                elseif regresion == 2
                    b0 = ones(1,length(Y));
                    b1 = 1:length(Y);
                    b2 = (1:length(Y)).^2;
                    
                    b = [Y*b0'; Y*(b1)' ;Y*(b2)'];
    
                    A = [ b0*b0' b0*b1' b0*b2'
                          b1*b0' b1*b1' b1*b2'
                          b2*b0' b2*b1' b2*b2'];
                    
                    c = A\b;
    
                    YY = b2*c(3) + b1*c(2) + c(1);
                else
                    b0 = ones(1,length(Y));
                    b1 = 1:length(Y);
                    
                    b = [Y*b0'
                         Y*(b1)'];
    
                    A = [ b0*b0' b0*b1'
                          b1*b0' b1*b1'];
                    
                    c = A\b;
    
                    YY = (1:length(Y))*c(2) + c(1);
                end

                SSn(index) = sum(power(Y - YY,2))/n;
                index = index + 1;
            end

            DFAS = sum(sqrt(SSn))/k;
            DFA = [DFA, DFAS];
            DFAN = [DFAN, n];
        end
    end
    %--------------------------------------------------------------------
    
    b0 = ones(1,length(DFA));
    b1 = log(DFAN);
    
    b = [log(DFA)*b0'
        log(DFA)*(b1)'];
    
    A = [ b0*b0' b0*b1' 
        b1*b0' b1*b1'];
    
    c = A\b;
    HURST = c(2);
    
    if is_plot == 1
        plot(b1, log(DFA), ".r",'markersize',10)
    
        hold on
      
        t = 0:round(max(log(DFAN))+2);
        l = c(1) + c(2)*t;
        plot(t, l, "-b",'LineWidth',1)
        t = unique(log(DFAN));
        l = c(1) + c(2)*t;
        hold on
        plot(t, l, "-r",'LineWidth',1)
        xlim([0 round(max(log(DFAN))+2)]);
        ylim([0 round(max(log(DFAN))+2)]);

    end
end