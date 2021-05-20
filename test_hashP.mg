load "./hashP.mg";

procedure hexToBin(~x)
    x:=Intseq(x,2);
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

test(0xCE8F, 0xB63A);
test(0x5A11, 0xB149);
test(0x76235204, 0xB3FCDDC1);

print "tested";