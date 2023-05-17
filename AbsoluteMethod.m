function HURST = AbsoluteMethod(data, exp, is_plot)
    f = data;
    
    K = length(f);
    xmean = mean(f);
    AM = [];
    AMN = [];
    

    for k = 2:K %pocet okien
        
        Xm = [];
        n = K/k; % velkost okna
        if n < 10
            break
        end
        if mod(K,k) == 0
            index = 0;
            for i = 0:n:K-1
                if i == 0
                    cr = i+1:i+n;
                else
                    cr = i:i+n;
                end

                index = index + 1;
                Xm(index) = mean(f(cr));
            end

            ami = sum((abs(Xm - xmean).^exp))/k;
            AM = [AM, ami];
            AMN = [AMN, n];
        end
    end
    
    %--------------------------------------------------------------------
    
    b0 = ones(1,length(AM));
    b1 = log(AMN);
    
    b = [log(AM)*b0'
        log(AM)*(b1)'];
    
    A = [ b0*b0' b0*b1' 
        b1*b0' b1*b1'];
    
    c = A\b;
    HURST = c(2)/exp+1; 
    
    if is_plot == 1
        plot(b1, log(AM), ".r",'markersize',10)
    
        hold on
      
        t = 0:round(max(log(AMN))+2);
        l = c(1) + c(2)*t;
        plot(t, l, "-b",'LineWidth',1)
        t = unique(log(AMN));
        l = c(1) + c(2)*t;
        hold on
        plot(t, l, "-r",'LineWidth',1)
        xlim([0 round(max(log(AMN))+2)]);
        ylim([0 round(max(log(AMN))+2)]);

    end
end