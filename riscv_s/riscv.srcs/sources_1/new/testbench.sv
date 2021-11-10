
`timescale 1ns / 1ps

module testbench();
logic clk;
logic reset;
logic [31:0] WriteData,DataAdr;
logic MemWrite;

top dut(clk,reset,WriteData,DataAdr, MemWrite);

initial 
    begin
        reset = 1; 
        #22;
        reset = 0;
    end
always begin
    clk =1; 
    #5;
    clk = 0;
    #5;
end

// always @(negedge clk) begin
//     if (MemWrite) begin
//         if (DataAdr === 100 & WriteData === 25) begin
//             $display("Simulation succeeded ");
//             $stop;
//         end else if (DataAdr !== 96) begin
//             $display("Simulation failed ");
//             $stop;
//         end
//     end
// end
    
    
endmodule
