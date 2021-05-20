load "./print_cipher.mg";
m:=VectorSpace(GF(2),48)![ 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0 ];
c:=VectorSpace(GF(2),48)![ 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 ];

function appendZerosToLength(x,l)
    append0ToBeginningToLength(~x,l);
    return x;
end function;
// SetLogFile("./task3.log");
stopOuterLoop:=false;
middleBits:=[0:i in [9..72]];
answerIsFound:=false;
bitsPermutations:=[appendZerosToLength(Intseq(i,2),8): i in [0..2^8-1]];
i:=0;
for leftBits in bitsPermutations do
    for rightBits in bitsPermutations do
        i;
        i:=i+1;
        k:=VectorSpace(GF(2),80)!(leftBits cat middleBits cat rightBits);
        cipher:=PRINTcipher(m,k);
        if cipher eq c then
            answerIsFound:=true;
            printf"Answer is nt found";
            k;
        end if;
    end for;
end for;
if not answerIsFound then
    printf"Answer not found";
end if;
