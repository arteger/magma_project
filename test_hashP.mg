load "./hashP.mg";

function IntToSeq(x,n)
    return Reverse(Prune(Intseq(x+2^n,2)));
end function;

procedure hexToBin(~x)
    x:=IntToSeq(x, #Intseq(x,2));
end procedure;

procedure hexToBinWithLength(~x, length)
    hexToBin(~x);
    if #x lt length then
        x:= [0: i in [1..length - #x]] cat x;
    end if;
end procedure;


procedure test(m0, m1)
    hexToBinWithLength(~m0, 520);
    hexToBinWithLength(~m1, 520);
    digest0:=hashP(m0);
    digest1:=hashP(m1);
    function_correct:=digest0 eq digest1;
    if not function_correct then
        printf"Wrong answer: \nh0=%o \nh1=%o \n",digest0,digest1;
    end if;
end procedure;

test(0x7f1aacd81c24eefe92614085ab88346fbd4108e8a16263a58375ecc2e0061e1196723e78cecd72106cc2c15994ad312e93ab4491d38eaaa782028aa035e21165f1, 0x4a93a51f7aca2d7b400b4c73d2ad5bd208b6ae29a9478021a2f6e3673f5a330e296fd89c02a6362c590b46f00b8996b0077e24e3837b8ad162dffd0b0d56fbed84);
