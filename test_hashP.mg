load "./hashP.mg";

function IntToSeq(x,n)
    return Reverse(Prune(Intseq(x+2^n,2)));
end function;

procedure hexToBin(~x)
    x:=IntToSeq(x, #Intseq(x,2));
end procedure;

procedure test(m0, m1)
    hexToBin(~m0);
    hexToBin(~m1);
    digest0:=hashP(m0);
    digest1:=hashP(m1);
    function_correct:=digest0 eq digest1;
    if not function_correct then
        printf "Wrong answer: \nh0=%o \nh1=%o \n",digest0,digest1;
    end if;
end procedure;

// test(0x200D4326940BDC5774ADCD0C193E0F0A, 0x4F75C747281E72CFC6985323701D1B76);
test(0x69F4, 0xF3D4);
// test(0x76235204, 0xB3FCDDC1);

print "tested";