
function Maha = PCA_2D(data,cw,m,step,progressbar)

    a = data;
    N_data = length(a);
    
    for z=1:N_data-(cw+m)
    
        for i=1:m
            X(i,:) = a(1+z+(i-1)*step:1+z+(i-1)*step+cw-1);
        end
        
        R = cov(X);    
        [U,S,V]=svd(R);    
        L = diag(S);    
        C = X*U;
        
        t = linspace(0,2*pi,1000);    
        e = [cos(t) ; sin(t)]; %# unit circle    
        k=2;    
        mBlue = mean(C(:,1:2));
        
        MBlue = [mBlue(1)*ones(1,1000)
            mBlue(2)*ones(1,1000)];
        
        covBlue = cov(C(:,1:2));    
        [uBlue,sBlue,vBlue]=svd(covBlue);    
        wBlue = uBlue*k*sqrt(sBlue);    
        eBlue = wBlue*e+MBlue;
        
        if (1+z+(i-1)*step+cw-1+1) > N_data
            break
        else
            aNew = a(1+z+(i-1)*step+1:1+z+(i-1)*step+cw-1+1);    
            cNew = aNew*U;        
            Maha(z) =((mBlue(1)-cNew(1)).^2/(k^2*sBlue(1,1)) + (mBlue(2)-cNew(2)).^2/(k^2*sBlue(2,2)))^(0.5)
        end    

        if progressbar.CancelRequested
            break
        end
    end
end