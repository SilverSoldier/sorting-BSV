import OEMerge8::*;
import Vector::*;

module mkTbOEMerge8();
  OEMerge8 merge <- mkOEMerge8();
  Reg#(Bool) start <- mkReg(False);
  Vector#(8, Reg#(Bit#(32))) a <- replicateM(mkReg(0));
  a[0] <- mkReg(6);
  a[1] <- mkReg(7);
  a[2] <- mkReg(8);
  a[3] <- mkReg(9);
  a[4] <- mkReg(2);
  a[5] <- mkReg(3);
  a[6] <- mkReg(4);
  a[7] <- mkReg(5);

  rule startTest(start == False);
  	merge.give(a);
  	start <= True;
  endrule

  rule endTest(start == True);
  	let x = merge.take();
  	for(Integer i = 0; i < 8; i = i+1) begin
  	  $display("%d ", x[i]);
  	end
  	$finish();
  endrule

endmodule
