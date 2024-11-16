`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2024 11:25:44 PM
// Design Name: 
// Module Name: cursor_impl
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


module cursor_impl(

    input  logic        Reset, 
    input  logic        frame_clk,
    input  logic [31:0]  keycode,
    // input logic [7:0]   keycode,

    output logic [9:0]  CursorX, 
    output logic [9:0]  CursorY, 
    output logic [9:0]  CursorS

    );

    parameter [9:0] Cursor_X_Center=320;  // Center position on the X axis
    parameter [9:0] Cursor_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Cursor_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Cursor_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Cursor_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Cursor_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Cursor_X_Step=1;      // Step size on the X axis
    parameter [9:0] Cursor_Y_Step=1;      // Step size on the Y axis

    logic [7:0] btn_keycode;
    logic [7:0] x_keycode;
    logic [7:0] y_keycode;
    logic [7:0] wheel_keycode;

    logic [9:0] Cursor_X_Motion;
    logic [9:0] Cursor_X_Motion_next;
    logic [9:0] Cursor_Y_Motion;
    logic [9:0] Cursor_Y_Motion_next;

    logic [9:0] Cursor_X_next;
    logic [9:0] Cursor_Y_next;

    assign btn_keycode = keycode[7:0];
    assign x_keycode = keycode[15:8];
    assign y_keycode = keycode[23:16];
    assign wheel_keycode = keycode[31:24];


    always_comb begin
        Cursor_Y_Motion_next = 10'd0; Cursor_Y_Motion; // set default motion to be same as prev clock cycle 
        Cursor_X_Motion_next = 10'd0; Cursor_X_Motion;

        // if (keycode == 8'h1A)  // W
        //     begin
        //         Cursor_Y_Motion_next = -10'd1;
        //         Cursor_X_Motion_next = 10'd0;
        //     end
        // if (keycode == 8'h04) // A
        //      begin
        //         Cursor_X_Motion_next = -10'd1;
        //         Cursor_Y_Motion_next = 10'd0;
        //     end
        // if (keycode == 8'h07) // D
        //     begin
        //         Cursor_X_Motion_next = 10'd1;
        //         Cursor_Y_Motion_next = 10'd0;
        //     end
        // if (keycode == 8'h16) // S
        //     begin
        //         Cursor_Y_Motion_next = 10'd1;
        //         Cursor_X_Motion_next = 10'd0;
        //     end

        // modify to control Cursor motion with the keycode
        // x dir
        Cursor_X_Motion_next = x_keycode;
        // if (x_keycode < 0) // x_keycode[7] == 1'b1
        //     begin
        //         Cursor_X_Motion_next = x_keycode[7:0];
        //     end
        // else if (x_keycode > 0) // x_keycode[15] == 1'b0
        //     begin
        //         Cursor_X_Motion_next = x; 
        //     end
        // else 
        //     begin
        //         Cursor_X_Motion_next = 10'd0; 
        //     end
        // y dir
        Cursor_Y_Motion_next = y_keycode;

        if ( (CursorY + CursorS) >= Cursor_Y_Max )  // Cursor is at the bottom edge, BOUNCE!
            begin
                Cursor_Y_Motion_next = (~ (Cursor_Y_Step) + 1'b1);  // set to -1 via 2's complement.
            end
        else if ( (CursorY - CursorS) <= Cursor_Y_Min )  // Cursor is at the top edge, BOUNCE!
            begin
                Cursor_Y_Motion_next = Cursor_Y_Step;
            end 

       //fill in the rest of the motion equations here to bounce left and right

        if ( (CursorX + CursorS) >= Cursor_X_Max) // Cursor is at the right edge
            begin
                Cursor_X_Motion_next = (~ (Cursor_X_Step) + 1'b1);
            end

        else if ( (CursorX - CursorS) <= Cursor_X_Min) // Cursor is at the left edge
            begin
                Cursor_X_Motion_next = Cursor_X_Step;
            end
     end

    assign CursorS = 4;  // default Cursor size
    assign Cursor_X_next = (CursorX + Cursor_X_Motion_next);
    assign Cursor_Y_next = (CursorY + Cursor_Y_Motion_next);
   
    always_ff @(posedge frame_clk) //make sure the frame clock is instantiated correctly
    begin: Move_Cursor
        if (Reset)
        begin 
            Cursor_Y_Motion <= 10'd0; //Cursorall_Y_Step;
			Cursor_X_Motion <= 10'd1; //Cursorall_X_Step;
            
			CursorY <= Cursor_Y_Center;
			CursorX <= Cursor_X_Center;
        end
        else 
        begin 

			Cursor_Y_Motion <= Cursor_Y_Motion_next; 
			Cursor_X_Motion <= Cursor_X_Motion_next; 

            CursorY <= Cursor_Y_next;  // Update Cursorall position
            CursorX <= Cursor_X_next;
			
		end  
    end

endmodule