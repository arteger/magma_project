function hashP(m0)
    //an input string of n bits to be hashed
    m:=m0; 
    // appending [1] to m
    m cat:=[1]; 
    // appending [0] to m so that 80 devides m
    m cat:= [0 : i in [1..80-(#m mod 80)]]; 

    //count the number of 80-bit blocks
    number_blocks:=#m/80;  

    // h0 = 0
    h :=VectorSpace(GF(2),48)!0; 

    //for each block compute h
    for i in [1..number_blocks]
        h := PRINTcipher(h, VectorSpace(GF(2),80)!m[(i-1)*80+1..80*i]) + h;
    end for;

    //define h as the 24-bit vector composed by the the 24 left-most bits of last computed h
    h:=VectorSpace(GF(2),24)![h[i]:i in [1..24]];

    //return the digest of m0
    return h;

end function;
