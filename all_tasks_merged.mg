/*
Exercise 1 
*/

//convert int to array of bits
function IntToSeq(x,n)
    return Reverse(Prune(Intseq(x+2^n,2)));
end function;

//convert int to the element of vector space mod 2 with length n 
function IntToVec(x,n)
    return VectorSpace(GF(2),n)!IntToSeq(x,n);
end function;

//convert the element of vector space mod 2 to int
function VecToInt(v)
	e:=Eltseq(v);
	ChangeUniverse(~e,Integers());
	return Seqint(Reverse(e),2);
end function;

//apply n-bit shift to register to get round counter    
procedure recomputeRegister(~x, ~n)
    t:=(1+x[1]+x[2]) mod 2;
    for i in [1..n-1] do
        x[i]:=x[i+1];
    end for;
    x[n]:=t;
end procedure;

//xor of round counter and least significant bits of the current state of the cipher
procedure leastSignificantBitsXor(~x, ~b, ~length)
    start:=#x-length+1;
    for i in [start..#x] do
        x[i]:=BitwiseXor(b[i-start+1],x[i]);
    end for;
end procedure;

//generate array with permutations for each S-box 
procedure generateSBoxPermutations(~x,~k,~permutations,length)
    permutationMaps:=[[0,1,3,6,7,4,5,2],[0,1,7,4,3,6,5,2],[0,3,1,6,7,5,4,2],[0,7,3,5,1,4,6,2]];
    permutations:=[];
    for i in [1..length] do
        permutation_type:=Integers()!(k[i*2-1]*2+k[i*2]+1);
        s_i:=Integers()!(4*x[i*3-2]+2*x[i*3-1]+x[i*3]+1);
        perm:=IntToVec(permutationMaps[permutation_type][s_i],3);
        Append(~permutations, perm);
    end for;
end procedure;

//mix the cipher state with S-box substitutions
procedure sBoxPermutate(~x, ~permutations)
    for i in [1..#permutations] do
        perm:=permutations[i];
        x[3*i-2]:=perm[1];
        x[3*i-1]:=perm[2];
        x[3*i]:=perm[3];
    end for;
end procedure;

//compute PRINTCipher for message m and key k,
// where m - VectorSpace(GF(2),48)
// where k - VectorSpace(GF(2),80)
function PRINTcipher(m,k)
    local b, c, register, permutations,temp;

    //size of the block
    b:=48;
    //length of the user key
    kLength:=b*5/3;
    //length of the second subkey sk2
    k2Length:=kLength-b;
    
    // convert m,k to array of integers to simplify computations
    m:=[m[i]:i in [1..b]];
    k:=[k[i]:i in [1..kLength]];
    ChangeUniverse(~m,Integers());
    ChangeUniverse(~k,Integers());
    //length of shift register
    n:=Integers()!Ceiling(Log(2,b));

    //round key, b-bit subkey sk1 of user key 
    k1:=[k[i]:i in [1..b]];  
    //second subkey sk2 for the key-dependent permutations  
    k2:=[k[i]:i in [b+1..kLength]];    
    c:=m;
    //shift register 
    register:=[0: i in [1..n]];

    permutations:=[];
    for round in [1..b] do
        //combine cipher state with a round key using bitwise xor
        for i in [1..b] do
            c[i]:=BitwiseXor(c[i],k1[i]);
        end for;
        temp:=c;
        //shuffle cipher state using a fixed linear diffusion layer,
        //position of first and last bits stays unchanged 
        for i in [1..b-1] do
            c[(3*(i-1) mod (b-1))+1]:=temp[i];
        end for;
        c[b]:=temp[b];
        //generate the value of the round counter RCi
        recomputeRegister(~register, ~n);
        //combine the round counter RCi with the least significant bits of the current state using xor
        leastSignificantBitsXor(~c,~register, ~n);
        //generate the 3-bit entry to each S-box 
        generateSBoxPermutations(~c,~k2,~permutations,k2Length/2);
        //mix the cipher state using a layer of b/3 non-linear S-box subtitutions 
        sBoxPermutate(~c,~permutations);
    end for;
    c:=VectorSpace(GF(2),b)!c;
    return c;
end function;

/*
Exercise 2 
*/

function hashP(m0)

    //an input string of n bits to be hashed
    m:=m0; 
    
    // appending [1] to m
    m cat:=[1]; 

    // appending [0] to m so that 80 devides m
    if #m mod 80 ne 0 then
        m cat:= [0 : i in [1..80-(#m mod 80)]]; 
    end if;

    //count the number of 80-bit blocks
    number_blocks:=#m/80;  

    // h0 = 0
    h:=VectorSpace(GF(2),48)!0; 

    //for each block compute h
    for i in [1..number_blocks] do
        h:= VectorSpace(GF(2),48)!PRINTcipher(h, VectorSpace(GF(2),80)!m[(i-1)*80+1..80*i]) + h;
    end for;

    //define h as the 24-bit vector composed by the the 24 left-most bits of last computed h
    h:=VectorSpace(GF(2),24)![h[i]:i in [1..24]];

    //return the digest of m0
    return h;

end function;

/*
Exercise 3 
*/

//given message and cipher 
m_task3:=VectorSpace(GF(2),48)![ 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0 ];
c_task3:=VectorSpace(GF(2),48)![ 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1 ];
procedure findKeyWithBruteForce(m,c) 
    //bits in positions from 9 to 72 are zero
    middleBits:=[0:i in [9..72]];
    answerIsFound:=false;
    bitsPermutations:=[IntToSeq(i,8): i in [0..2^8-1]];
    i:=0;
    for leftBits in bitsPermutations do
        for rightBits in bitsPermutations do
            i;
            i:=i+1;
            //generate possible key 
            k:=VectorSpace(GF(2),80)!(leftBits cat middleBits cat rightBits);
            //compute cipher with possible key 
            cipher:=PRINTcipher(m,k);
            //check if computed cipher is equal to the given cipher 
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
end procedure;

// findKeyWithBruteForce(m_task3, c_task3);

/*
Exercise 4 
*/

procedure findColisions(length)
    local message,hash,defined,val;
    SetLogFile("Collisions_" cat IntegerToString(length) cat ".log");
    //create hashmap to save values message and its computed hash
    //hashmap is used to check hash existance for O(1)
    hashMap := AssociativeArray();
    colissionCounter:=1;
    while true do
        //generate random message
        message:=[1] cat [Random(0,1): i in [1..length-1]];
        //generate hash of the message 
        hash:=hashP(message);
        //check if there is same hash value with different message in the hashmap
        defined, val:=IsDefined(hashMap, hash);
        if defined and (val ne message)  then
            printf"Collision %o found.x1=\"%h\" x2=\"%h\"\n",colissionCounter,VecToInt(val),VecToInt(message);
            colissionCounter:=colissionCounter+1;
        end if;
        //add current hash with message to the hashMap
        hashMap[hash]:=message;
    end while;
end procedure;

//findColisions(2000);  