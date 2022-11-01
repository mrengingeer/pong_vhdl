# pong_vhdl

In this project, the video-output subsystem and Video Graphic Adaptor (VGA) standards,
as well as FPGA to I/O device interfacing was investigated. Using VHDL coding techniques, the
common Ping Pong game was implemented and tested with static frames. Each frame, depending
on the clock cycle, outputted a static green background with a white border and gates to score in.
Each gate contains a player, one blue one pink, to defend from the ball entering and scoring for
the opponent. The square yellow ball moved in a diagonal direction and changed its trajectory if
a collision occurred. A collision happened if the ball came into contact with either a player or the
white border. The trajectory would change by 90 angular degrees so if the ball was headed down
and came into contact with the bottom border, it was now headed in the upward diagonal
direction. Overall, the HSync and VSync signals were studied and analyzed. The implementation
and testing occurred through the testbench file which outputted results to a log file titled
‘write.txt’. Each line of the file contained the hsync, vsync, red, green and blue signals. The file
was then uploaded to a VGA simulator which outputted the results in different frames for the
game as it progressed (as the ball and players moved). Overall, the implementation of the Simple
Video Game Processor for VGA was successful and functions according to the specifications.

The objective of this project is to understand the functionality of video-output subsystem
and Video Graphic Adaptor (VGA) standards, as well as to investigate on-chip (FPGA) to I/O
device interfacing. VHDL coding techniques in the environment of Xillinx ISE CAD system
were implemented to create and simulate a simple video game processor. This project allowed a
means to gain practical experience in designing and implementing real-time signal generators in
FPGAs with custom logic circuits. The Ping Pong game created consists of two players, where
each player moved vertically in an attempt to prevent a ball from entering the scoring gate on
their side of the field. The ball bounced off the borders of the game and the player's paddles as
well. The design of the project utilized different colors to represent various objects in the game;
Player 1 is blue, whereas Player 2 is pink, the ball is represented with a yellow square, however
turns red, when it travels past the scoring gates. The ball also changed trajectory, as it bounced
off the borders and players’ paddles. Upon the completion of the VHDL code, a test bench file


