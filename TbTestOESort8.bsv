import OESort8::*;
import Vector::*;

module mkTbOESort8();
  OESort8 sort <- mkOESort8();
  Reg#(Bool) start <- mkReg(False);
  Vector#(8, Reg#(Bit#(32))) a <- replicateM(mkReg(0));
  a[0] <- mkReg(3);
  a[1] <- mkReg(9);
  a[2] <- mkReg(8);
  a[3] <- mkReg(5);
  a[4] <- mkReg(10);
  a[5] <- mkReg(6);
  a[6] <- mkReg(2);
  a[7] <- mkReg(1);

  rule startTest(start == False);
  	sort.give(a);
  	start <= True;
  endrule

  rule endTest(start == True);
  	let x = sort.take();
  	for(Integer i = 0; i < 8; i = i+1) begin
  	  $display("%d ", x[i]);
  	end
  	$finish();
  endrule

endmodule
