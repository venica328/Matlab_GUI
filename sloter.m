
function s = sloter(value,d,N,te,PacketLength) 
   
    s = table();    % ulozime vystupy v podobe 'a' a 'b'

    % prepocita sa algoritmus naraz pre pakety a casy
    if value == 1
        
        T = 0;
        I = 0;
        P = 0; 
        a = 0;  % prirastky casu
        b = 0;  % prirastky paketov      
        for i=1:N-1
            T=T+te(i);
            if mod(i,1000) == 0
               i
            end
            if T>d
               a = [a , I];
               b = [b , P];
               I=1;
               P=1;
               T=T-d;
               if T>d
                  I=0;
                  P=0;
               end
            else
               I = I+1;
               P = P + PacketLength(i);
            end
        end
        % do vystupnej tabulky pridame a potom b 
        s = addvars(s,a);
        s = addvars(s,b);

    % prepocita sa algoritmus bez paketov a casov naraz, pocitaju sa iba casy
    else

        T = 0;
        I = 0;
        a = 0;  % prirastky casu    
        for i=1:N-1
            T=T+te(i);
            if mod(i,1000) == 0
                i
            end
            if T>d
               a = [a , I];
               I=1;
               T=T-d;
               if T>d
                  I=0;
               end
            else
               I = I+1;
            end
        end
        s = addvars(s,a);
    end