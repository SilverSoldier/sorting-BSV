import Vector::*;
import OEMerge8::*;
import OESort4::*;

`define n 8

`define m 4

`define integer 32

interface OESort8;
  method Action give(Vector#(`n, Reg#(Bit#(`integer))) a);
  method Vector#(`n, Reg#(Bit#(`integer))) take();
endinterface

module mkOESort8(OESort8);
  Vector#(`n, Reg#(Bit#(`integer))) numbers <- replicateM(mkReg(0));
  Reg#(int) state <- mkReg(0);
  OESort4 half1 <- mkOESort4();
  OESort4 half2 <- mkOESort4();
  OEMerge8 merger <- mkOEMerge8();

  rule split(state == 1);
	half1.give(take(numbers));
	half2.give(takeAt(`m, numbers));

	state <= 2;
  endrule

  rule sort_take(state == 2);
  	let x = half1.take();
  	let y = half2.take();

  	// Write results back into numbers
  	for(Integer i = 0; i < `m; i = i + 1) begin
  	  numbers[i] <= x[i];
  	end

  	for(Integer i = `m; i < `n; i = i + 1) begin
  	  numbers[i] <= y[i - `m];
  	end

  	state <= 3;
  endrule

  rule merge_give(state == 3);
  	merger.give(numbers); 
  	state <= 4;
  endrule

  rule merge_take(state == 4);
  	let x = merger.take();
  	for(Integer i = 0; i < `n; i = i + 1) begin
  	  numbers[i] <= x[i];
  	end
  	state <= 5;
  endrule

  method Action give(Vector#(`n, Reg#(Bit#(`integer))) a);
  	for(Integer i = 0; i < `n; i = i +1) begin
  	  numbers[i] <= a[i];
  	end
  	state <= 1;
  endmethod

  method Vector#(`n, Reg#(Bit#(`integer))) take() if(state == 5);
  	return numbers;
  endmethod

endmodule
