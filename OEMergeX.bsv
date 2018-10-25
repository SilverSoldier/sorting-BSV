import Vector::*;
import OEMergeY::*;

`define n X

`define m Y

`define integer 32

interface OEMergeX;
  method Action give(Vector#(`n, Reg#(Bit#(`integer))) a);
  method Vector#(`n, Reg#(Bit#(`integer))) take();
endinterface

module mkOEMergeX(OEMergeX);
  Vector#(`n, Reg#(Bit#(`integer))) numbers <- replicateM(mkReg(0));
  Reg#(int) state <- mkReg(0);
  OEMergeY half1 <- mkOEMergeY();
  OEMergeY half2 <- mkOEMergeY();

  rule split(state == 1);
  	for(Integer i = 1; i < `m; i = i+1)
  	  numbers[i] <= numbers[2*i];

  	for(Integer i = `m; i < `n - 1; i = i+1)
  	  numbers[i] <= numbers[(i - `m)*2 + 1];

  	state <= 2;
  endrule

  rule sort_give(state == 2);

	// Sort the first and second halves separately
	half1.give(take(numbers));
	half2.give(takeAt(`m, numbers));

	state <= 3;

  endrule

  rule sort_take(state == 3);
  	let x = half1.take();
  	let y = half2.take();

  	// Write results back into numbers
  	for(Integer i = 0; i < `m; i = i + 1) begin
  	  numbers[i] <= x[i];
  	end

  	for(Integer i = `m; i < `n; i = i + 1) begin
  	  numbers[i] <= y[i - `m];
  	end

  	state <= 4;
  endrule

  rule merge(state == 4);
  	Integer j = 1;
  	for(Integer i = 1; i < `m; i = i+1) begin
  	  numbers[j] <= min(numbers[i], numbers[i+`m-1]);
  	  numbers[j+1] <= max(numbers[i], numbers[i+`m-1]);
  	  j = j+2;
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
