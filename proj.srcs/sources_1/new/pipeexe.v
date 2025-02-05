`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cun
// 
// Create Date: 2023/05/20 20:34:52
// Design Name: 
// Module Name: pipeexe
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
//done
module pipeexe (ealuc, ealuimm, ea, eb, eimm, eshift, ern0, epc4, ejal, ern, ealu); //EXE stage
    input [31:0] ea, eb, eimm, epc4;
    input [4:0] ern0;
    input [3:0] ealuc;
    input ealuimm, eshift, ejal;
    output [31:0] ealu;
    output [4:0] ern;
    wire [31:0] alua, alub, sa, ealu0, epc8;
    wire z;
    assign sa = {eimm[5:0], eimm[31:6]};
    assign epc8 = epc4; //the better solution for branch hazard.
    mux2x32 alu_ina (ea, sa, eshift, alua);
    mux2x32 alu_inb (eb, eimm, ealuimm, alub);
    mux2x32 save_pc8 (ealu0, epc8, ejal, ealu);
    assign ern = ern0 | {5{ejal}};  //IF jal then set this to $ra
    alu al_unit (alua, alub, ealuc, ealu0, z);
    
endmodule