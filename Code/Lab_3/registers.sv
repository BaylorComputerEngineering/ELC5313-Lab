module Registers(
// clock and flag indicating that a new instruction has been issued
   input logic clock, issue,

// register numbers 0-31, analogous to Read_Register1, Read_Register2, Write_Register
   input logic [4:0] A_address,B_address, dest,

// data to write, analogous to write_data
   input logic [31:0] In_data,
    
   input logic [5:0] In_source, RS_calculating_value,

// flag indicating that the intent is to write to the register file, analogous to reg_write

   input logic write,

 // data out of the register file analogous to read_data1 and read_data2
   output logic [31:0] A_out, B_out,

// flag indicating that the data in the register in not updated and ready to use
   output logic A_invalid,B_invalid
   );

// define parameters to use as constant values
   parameter not_redirected=0;
   parameter true=1'b1;
   parameter false=1'b0;
   parameter num_of_regs=32;
   
 // 32 elements of 32 bit values in the register file
   logic [31:0] reg_file [31:0];

// 32 elements of 5 bit values indicating the reservation station
   logic [5:0] redirection [31:0];

 // loop variable
   integer i;
   
   initial
     begin
       for(i=0;i<num_of_regs;i=i+1)
         begin
             reg_file[i]=i;
             redirection[i]=not_redirected;
         end
     end 

// Big picture of what is going on in this module
// This is overall similar to the regfile in Comp Org with the same ideas: read values from 2 registers, 
// write value to 1 register. However, since this is out of order execution:   
// 1. The read values may or may not be ready to use. If ready, send them out. If they are not ready because
// they are being calculated by a reservation station in the ALU, then we identify they are not ready and output the 
// reservation station number they are waiting for.
// 2. Unlike in Comp Org, the destination register will not be updated right now. Instead, we store the producing
// reservation station for that destination register. The value of the destination register will be updated later when
// the producing reservation station finishes executing.
// 3. Even though we are not updating the destination register immediately, we still have a value that is intended to 
// be written to the register file. But rather than writing it to the destination register, it gets written to the register
// that is waiting on data from that reservation station. So we keep up with which reservation station is supposed to 
// produce the value for the destination register (described in step 2 above), then when data produced by that reservation
// station comes in, we update the register that was waiting on the data
   
   always@(negedge clock)
   begin
	// TODO handle issue
   end
         
       
    always@(posedge clock)
       begin
          // TODO handle updates
       end
endmodule
