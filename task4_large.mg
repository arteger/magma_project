load "./hashP.mg";

procedure findColisions(length)
    local message,hash,defined,val;
    SetLogFile("Collisions" cat IntegerToString(length) cat ".log");
    i:=0;
    colissionCounter:=1;
    maxValues:=2^(length-1);
    while true and i lt maxValues do
        message:= [Random(0, 1): i in {1..length}];
        hash:=hashP(message);
        printf"\"%h\", \"%h\"\n", VecToInt(message), VecToInt(hash);
        i:=i+1;
        // Keys(hashMap);
        // i;
        
    end while;
end procedure;


// findColisions(20000);