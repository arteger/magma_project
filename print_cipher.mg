procedure append0ToBeginningToLength(~a, l)
    if #a lt l then
        a:= a cat [0 : i in [1..l-#a]];
    end if;
end procedure;

procedure recomputeRegister(~x, n)
    t:=(1+x[n]+x[n-1]) mod 2;
    for i in Reverse([2..n]) do
        x[i]:=x[i-1];
    end for;
    x[1]:=t;
end procedure;

procedure leastSignificantBitsXor(~x, ~b, length)
    for i in [1..length] do
        x[i]:=BitwiseXor(b[i],x[i]);
    end for;
end procedure;

procedure generateSBoxPermutations(~x,~k,~permutations,length)
    permutationMaps:=[[0,1,3,6,7,4,5,2],[0,1,7,4,3,6,5,2],[0,3,1,6,7,5,4,2],[0,7,3,5,1,4,6,2]];
    permutations:=[];
    for i in [1..length] do
        permutation_type:=Integers()!(k[i*2-1]+2*k[i*2]+1);
        s_i:=Integers()!(x[i*3-2]+2*x[i*3-1]+4*x[i*3]+1);
        perm:=Intseq(permutationMaps[permutation_type][s_i],2);
        append0ToBeginningToLength(~perm,3);
        Append(~permutations, perm);
    end for;
end procedure;

procedure sBoxPermutate(~x, ~permutations)
    for i in [1..#permutations] do
        perm:=permutations[i];
        x[3*i-2]:=perm[1];
        x[3*i-1]:=perm[2];
        x[3*i]:=perm[3];
    end for;
end procedure;

function PRINTcipher(m,k)
    b:=Integers()!48;
    kLength:=Integers()!(b*5/3);
    k2Length:=kLength-b;
    m:=[Integers()!m[i]:i in [1..b]];
    k:=[Integers()!k[i]:i in [1..kLength]];
    append0ToBeginningToLength(~m,b);
    append0ToBeginningToLength(~k,kLength);

    n:=Integers()!Ceiling(Log(2,b));

    k1:=[k[i]:i in [k2Length+1..kLength]];    
    k2:=[k[i]:i in [1..k2Length]];    
    c:=m;
    register:=[0: i in [1..n]];
    permutations:=[];
    for round in [1..b] do
        for i in [1..b] do
            c[i]:=BitwiseXor(c[i],k1[i]);
        end for;
        temp:=c;
        for i in [1..b-1] do
            c[(3*(i-1) mod (b-1))+1]:=temp[i];
        end for;
        c[b]:=temp[b];
        recomputeRegister(~register, n);
        leastSignificantBitsXor(~c,~register, n);
        generateSBoxPermutations(~c,~k2,~permutations,k2Length/2);
        sBoxPermutate(~c,~permutations);
    end for;
    c:=VectorSpace(GF(2),b)!c;
    return c;
end function;