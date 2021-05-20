load "./hashP.mg";

procedure incrementMessage(~message, ~length)
    message[length]:=message[length] + 1;
    for i in Reverse([2..length]) do
        if message[i] eq 2 then
            message[i-1]:=message[i-1]+1;
            message[i]:=0;
        end if;
    end for;
end procedure;

procedure findColisions(length)
    local message,hash,defined,val;
    SetLogFile("Collisions" cat IntegerToString(length) cat ".log");
    hashMap := AssociativeArray();
    message:=[1] cat [0: i in [1..length-1]];
    i:=0;
    colissionCounter:=1;
    maxValues:=2^(length-1);
    while true and i lt maxValues do
        hash:=hashP(message);
        defined, val:=IsDefined(hashMap, hash);
        if defined then
            printf"Collision %o found.x1=%h x2=%h\n",colissionCounter,VecToInt(val),VecToInt(message);
            colissionCounter:=colissionCounter+1;
        end if;
        hashMap[hash]:=message;
        incrementMessage(~message, ~length);
        i:=i+1;
        // Keys(hashMap);
        i;
    end while;
end procedure;


// findColisions(20000);