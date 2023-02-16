

function [Ent] = Ent(data)
    % vypocet pravdepodobnosti tried z histogramu, Matlab dava asi default
    % 10 tried, niektore mi ale vyskocili nulove, preto som to potom v
    % cykle osetril
    pdf = hist(data)./sum(hist(data));
    n = length(pdf);
    for k=1:n
        if pdf(k)==0
           pdf(k) = 10^(-20);
        end
    end
    % vypocet Entropie pre "data", isto ale v Matlabe najdete nejaku jeho
    % funkciu
    Ent = -sum(pdf.*log(pdf));
end