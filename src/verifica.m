function verifica(i,j)
global bw;
bw(i,j)=0;
for k=-1:1
    for c=-1:1
        if bw(i+k,j+c)==1
            verifica(k+i,j+c);
        end
    end
end
end