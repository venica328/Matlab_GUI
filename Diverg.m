



function [Diverg] = Diverg(data1,data2)


    pdf1 = hist(data1)./sum(hist(data1));
    n = length(pdf1);
    for k=1:n
        if pdf1(k)==0
           pdf1(k) = 10^(-20);
        end
    end

    pdf2 = hist(data2)./sum(hist(data2));
    n = length(pdf2);
    for k=1:n
        if pdf2(k)==0
           pdf2(k) = 10^(-20);
        end
    end

    Diverg = sum(pdf1.*log(pdf1./pdf2));
end