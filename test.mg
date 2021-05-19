load "./print_cipher.mg";

x:="0x4C847555C35B";
k:="0xC28895BA327B69D2CDB6";
expected_result:="0xEB4AF95E7D37";
actual_result:=PRINTcipher(x,k);
actual_result;
actual_result eq expected_result;