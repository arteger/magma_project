load "./hashP.mg";

procedure findColisions(length)
    local message,hash,defined,val;
    SetLogFile("Collisions_" cat IntegerToString(length) cat ".log");
    hashMap := AssociativeArray();
    colissionCounter:=1;
    while true do
        message:=[1] cat [Random(0,1): i in [1..length-1]];
        hash:=hashP(message);
        defined, val:=IsDefined(hashMap, hash);
        if defined then
            printf"Collision %o found.x1=\"%h\" x2=\"%h\"\n",colissionCounter,VecToInt(val),VecToInt(message);
            colissionCounter:=colissionCounter+1;
        end if;
        hashMap[hash]:=message;
    end while;
end procedure;
//x1="0x80B4B486748E6B6332BD8FB04" x2="0xAFB990544B50E8FF5A525F33F" 100 bit

findColisions(2000);