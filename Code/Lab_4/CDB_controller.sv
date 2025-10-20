module CDB_controller(
   input logic clock,
   input logic [4:0] rts,
   output logic [4:0] xmit
);
   logic [2:0] priority_sequence [2:0];
   logic [2:0] next_sequence [2:0];
   logic assigned;
   logic in_use;
   integer i;
   
   initial
   begin
       xmit<=0;
       in_use<=0;
       for(i=0;i<5;i=i+1)
          priority_sequence[i]=i;
   end
   
   always@(posedge(clock))
   begin
       for(i=0;i<3;i=i+1)
          next_sequence[i]<=priority_sequence[i];
       in_use<=1; 
       assigned<=0;
       for(i=0;i<5;i=i+1)
       begin
           if(~assigned)
           begin
               //rotate next priority
               if (rts[priority_sequence[i]]==1)
               begin
                   assigned<=1;
                   xmit[priority_sequence[i]]<=1;
               end
               else
               begin
                   xmit[priority_sequence[i]]<=0;
               end
           end
           else
           begin
               xmit[priority_sequence[i]]<=0;
           end
       end
       #1 
       for(i=0;i<3;i=i+1)
       priority_sequence[i]<=next_sequence[i];
   end
endmodule
