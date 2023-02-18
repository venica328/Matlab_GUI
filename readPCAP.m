function p = readPCAP(path,filename)

    p = table();

    %citanie PCAP suboru a rozparsovanie do tabulky
    pcapReaderObj = pcapReader(fullfile(path, filename),OutputTimestampFormat='microseconds');
    decodedPackets = readAll(pcapReaderObj);
    %pcapLength = length(decodedPackets);
    pcapAsTable = struct2table(decodedPackets);
    
    % ulozime si stlpec z tabulky pcapAsTable do vektoru Time
    app.Timestamp = pcapAsTable(:,2);
    Time = table2array(app.Timestamp);
    % ulozime si stlpec z tabulky pcapAsTable do vektoru Packet
    app.PacketLength = pcapAsTable(:,5);
    Packet = table2array(app.PacketLength);


    p = addvars(p,Time);
    p = addvars(p,Packet);
end


