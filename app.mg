b:=Integers()!48;
kLength:=Integers()!(b*5/3);
k2Length:=kLength-b;

function append0ToBeginningToLength(a, l)
    if #a lt l then
        a:=[0 : i in [1..l-#a]] cat a;
    end if;
    return a;
end function;

function hexToBinVectorSpaceOfLength(x,l)
    seq:=Intseq(x,2);
    full_seq:=append0ToBeginningToLength(seq,l);
    return VectorSpace(GF(2),l)!full_seq;
end function;


m:=hexToBinVectorSpaceOfLength(0x4C847555C35B,b);
k:=hexToBinVectorSpaceOfLength(0xC28895BA327B69D2CDB6,bl);

k1:=VectorSpace(GF(2),b)![k[i]:i in [1..b]];    
k2:=VectorSpace(GF(2),k2Length)![k[i]:i in [(b+1)..kLength]];    

for i in [1..b] do
x123:=1;
end for;