load "./print_cipher.mg";

procedure hexToBinVectorSpaceOfLength(~x,l)
    seq:=Intseq(x,2);
    append0ToBeginningToLength(~seq,l);
    x:=VectorSpace(GF(2),l)!seq;
end procedure;

procedure test(m, k, expected)
    hexToBinVectorSpaceOfLength(~m,48);
    hexToBinVectorSpaceOfLength(~k,80);
    cipher:=PRINTcipher(m, k);
    cipher:=[Integers()!cipher[i]:i in [1..48]];
    cipher:=Seqint(cipher,2);
    function_correct:=expected eq cipher;
    if not function_correct then
        error("Wrong answer: m=%o k=%o expected_result=%o actual_result=%o\n",m,k,expected,cipher);
    end if;
end procedure;

test(0x000000000000, 0x00000000000000000000, 0x291C50FBCC3E);
test(0xFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFFFFFF, 0x11E2ADE05DA1);
test(0x4C847555C35B, 0xC28895BA327B69D2CDB6, 0xEB4AF95E7D37);
test(0x956D54011A3F, 0x64000000000000000042, 0x7A97BAA84F2F);
print "All tests passed correctly.";