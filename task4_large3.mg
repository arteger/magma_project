load "./hashP.mg";

procedure findColisions(length)
    local message,hash,defined,val;
    while true do
        message:= [Random(0, 1): i in {1..length}];
        hash:=hashP(message);
        fprintf"collisions_1000000_3_kyr.log","\"%h\", \"%h\"\n", VecToInt(message), VecToInt(hash);
    end while;
end procedure;


// findColisions(20000);