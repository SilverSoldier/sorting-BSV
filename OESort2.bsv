import Vector::*;

`define n 2

`define integer 32

interface OESort2;
  method Action give(Vector#(`n, Reg#(Bit#(`integer))) a);
  method Vector#(`n, Reg#(Bit#(`integer))) take();
endinterface

module mkOESort2(OESort2);
  Vector#(`n, Reg#(Bit#(`integer))) numbers <- replicateM(mkReg(0));
  Reg#(int) state <- mkReg(0);

  rule sort(state == 1);
  	if(numbers[0] > numbers[1]) begin
  	  numbers[0] <= numbers[1];
  	  numbers[1] <= numbers[0];
  	end

  	state <= 2;
  endrule


  method Action give(Vector#(`n, Reg#(Bit#(`integer))) a);
  	for(Integer i = 0; i < `n; i = i +1) begin
  	  numbers[i] <= a[i];
  	end
  	state <= 1;
  endmethod

  method Vector#(`n, Reg#(Bit#(`integer))) take() if(state == 2);
  	return numbers;
  endmethod

endmodule
