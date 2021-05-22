load "./hashP.mg";

procedure findColisions(length)
    local message,hash,defined,val;
    while true do
        message:= [1] cat [Random(0, 1): i in [1..length-1]];
        hash:=hashP(message);
        fprintf"collisions_20000_1_kyr.log","\"%h\", \"%h\"\n", VecToInt(message), VecToInt(hash);
    end while;
end procedure;


findColisions(1000);