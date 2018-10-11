// Given a 8 inputs whose first half and second half is sorted -> merges both to give a completely sorted list

import Vector::*;

`define n 8

`define inp 256

`define integer 32

interface OEMerge8;
  method Action give(Vector#(`n, Bit#(`integer)) a);
  method ActionValue#(Bit#(`inp)) take();
endinterface

module mkOEMerge8(OEMerge8);
  Vector#(`n, Reg#(int)) numbers <- replicateM(mkReg(0));

  method Action give(Vector#(`n, Bit#(`integer)) a);
  	for(Integer i = 0; i < `n; i = i +1) begin
  	  numbers[i] <= unpack(a[i]);
  	end
  endmethod

  method ActionValue#(Bit#(`inp)) take();
  	Vector#(`n, Bit#(`integer)) result;
  	for(Integer i = 0; i < `n; i = i +1) begin
  	  result[i] = pack(numbers[i]);
  	end
  	return pack(result);
  endmethod

endmodule
