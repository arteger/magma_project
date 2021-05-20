load "./print_cipher.mg";
function IntToSeq(x,n)
    return Reverse(Prune(Intseq(x+2^n,2)));
end function;

m:=VectorSpace(GF(2),48)![ 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0 ];
c:=VectorSpace(GF(2),48)![ 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 ];

middleBits:=[0:i in [9..72]];
answerIsFound:=false;
bitsPermutations:=[IntToSeq(i,8): i in [0..2^8-1]];
i:=0;
for leftBits in bitsPermutations do
    for rightBits in bitsPermutations do
        i;
        i:=i+1;
        k:=VectorSpace(GF(2),80)!(leftBits cat middleBits cat rightBits);
        cipher:=PRINTcipher(m,k);
        if cipher eq c then
            answerIsFound:=true;
            printf "Answer is found\n";
            answer:=VecToInt([k[i]: i in [1..80]]);
            answer;
            break leftBits;
        end if;
    end for;
end for;
if not answerIsFound then
    printf "Answer not found";
end if;
//answer is 1048365359197061237440588 = 0xDE00000000000000004C