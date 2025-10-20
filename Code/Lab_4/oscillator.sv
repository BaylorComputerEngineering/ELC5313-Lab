module oscillator(
output logic clock
);
   initial
      clock<=0;
      
   always@*
      #10 clock<=~clock;
endmodule   
