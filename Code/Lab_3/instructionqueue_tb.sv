module instructionqueue_tb;
    
    logic clk=0;
    logic error=0;
    logic available=0;
    logic [5:0] RS_available=0;
    logic [5:0] RS_issue;
    logic [5:0] RS_exec=0;
    logic adder_rts=0;
    logic [5:0] RS_xmit=0;
    
    logic[5:0] opcode;
    logic[2:0] exec_unit;
    logic[4:0] A_address;
    logic[4:0] B_address;
    logic[4:0] Dest_address;
    logic issue;
    
    parameter clk_period=10;
    
    initial
    begin
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=1;
        RS_available<=1;
        RS_issue<=0;
        RS_exec<=0;
        adder_rts<=0;
        RS_xmit<=0;
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=1;
        RS_available<=2;
        RS_issue<=0;
        RS_exec<=0;
        adder_rts<=0;
        RS_xmit<=0;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=1;
        RS_available<=3;
        RS_issue<=0;
        RS_exec<=0;
        adder_rts<=0;
        RS_xmit<=0;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=0;
        RS_available<=0;
        RS_issue<=0;
        RS_exec<=3;
        adder_rts<=0;
        RS_xmit<=0;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=0;
        RS_available<=0;
        RS_issue<=0;
        RS_exec<=0;
        adder_rts<=1;
        RS_xmit<=0;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=0;
        RS_available<=0;
        RS_issue<=0;
        RS_exec<=0;
        adder_rts<=0;
        RS_xmit<=3;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=1;
        RS_available<=3;
        RS_issue<=0;
        RS_exec<=2;
        adder_rts<=0;
        RS_xmit<=0;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
        
        error<=0;
        available<=0;
        RS_available<=0;
        RS_issue<=0;
        RS_exec<=0;
        adder_rts<=1;
        RS_xmit<=0;
        
        
        #clk_period clk=~clk;
        RS_issue<=RS_available;
        #clk_period clk=~clk;
    end
    
    instructionqueue the_iq(
        .clock(clk),
        .issue_error(error),
        .adder_available(available),
        .adder_RS_available(RS_available),
        .RS_issued(RS_issue),
        .RS_executing_adder(RS_exec),
        .adder_rts(adder_rts),
        .RS_finished(RS_xmit),
        .operation(opcode),
        .execution_unit(exec_unit),
        .Dest_address(Dest_address), 
        .A_address(A_address), 
        .B_address(B_address),
        .issue(issue)
    );
endmodule
