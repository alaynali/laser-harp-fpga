
Q
Command: %s
53*	vivadotcl2 
route_design2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7s502default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7s502default:defaultZ17-349h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
V
DRC finished with %s
79*	vivadotcl2
0 Errors2default:defaultZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px� 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px� 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px� 
Z
%s*common2A
-Phase 1 Build RT Design | Checksum: 68c3e7c9
2default:defaulth px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:23 ; elapsed = 00:00:21 . Memory (MB): peak = 2865.781 ; gain = 0.0002default:defaulth px� 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px� 
{

Phase %s%s
101*constraints2
2.1 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px� 
e
%s*common2L
8Phase 2.1 Fix Topology Constraints | Checksum: 68c3e7c9
2default:defaulth px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:23 ; elapsed = 00:00:21 . Memory (MB): peak = 2865.781 ; gain = 0.0002default:defaulth px� 
t

Phase %s%s
101*constraints2
2.2 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px� 
^
%s*common2E
1Phase 2.2 Pre Route Cleanup | Checksum: 68c3e7c9
2default:defaulth px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:23 ; elapsed = 00:00:21 . Memory (MB): peak = 2865.781 ; gain = 0.0002default:defaulth px� 
p

Phase %s%s
101*constraints2
2.3 2default:default2!
Update Timing2default:defaultZ18-101h px� 
[
%s*common2B
.Phase 2.3 Update Timing | Checksum: 1195cd5b2
2default:defaulth px� 
�

%s
*constraints2o
[Time (s): cpu = 00:00:27 ; elapsed = 00:00:26 . Memory (MB): peak = 2865.781 ; gain = 0.0002default:defaulth px� 
�
Intermediate Timing Summary %s164*route2N
:| WNS=-74.338| TNS=-11748.863| WHS=-1.330 | THS=-306.724|
2default:defaultZ35-416h px� 
}

Phase %s%s
101*constraints2
2.4 2default:default2.
Update Timing for Bus Skew2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
2.4.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
]
%s*common2D
0Phase 2.4.1 Update Timing | Checksum: 1aec7a43f
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:28 ; elapsed = 00:00:30 . Memory (MB): peak = 2951.750 ; gain = 85.9692default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-74.338| TNS=-11740.058| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
h
%s*common2O
;Phase 2.4 Update Timing for Bus Skew | Checksum: 1d9aaa1f6
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:28 ; elapsed = 00:00:30 . Memory (MB): peak = 2951.750 ; gain = 85.9692default:defaulth px� 
a
%s*common2H
4Phase 2 Router Initialization | Checksum: 195f27250
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:29 ; elapsed = 00:00:30 . Memory (MB): peak = 2951.750 ; gain = 85.9692default:defaulth px� 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px� 
q

Phase %s%s
101*constraints2
3.1 2default:default2"
Global Routing2default:defaultZ18-101h px� 
\
%s*common2C
/Phase 3.1 Global Routing | Checksum: 195f27250
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:29 ; elapsed = 00:00:30 . Memory (MB): peak = 2951.750 ; gain = 85.9692default:defaulth px� 
[
%s*common2B
.Phase 3 Initial Routing | Checksum: 1f6cf4f52
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:34 ; elapsed = 00:00:34 . Memory (MB): peak = 2953.613 ; gain = 87.8322default:defaulth px� 
�
>Design has %s pins with tight setup and hold constraints.

%s
244*route2
752default:default2�
�The top 5 pins with tight setup and hold constraints:

+====================+====================+=====================================+
| Launch Setup Clock | Launch Hold Clock  | Pin                                 |
+====================+====================+=====================================+
| clk_100            | clk_out1_clk_wiz_0 | audio/sine_wave/phase_fun_reg[31]/D |
| clk_100            | clk_out1_clk_wiz_0 | audio/sine_wave/phase_fun_reg[30]/D |
| clk_100            | clk_out1_clk_wiz_0 | audio/sine_wave/phase_fun_reg[29]/D |
| clk_100            | clk_out1_clk_wiz_0 | audio/sine_wave/phase_fun_reg[25]/D |
| clk_100            | clk_out1_clk_wiz_0 | audio/sine_wave/phase_fun_reg[28]/D |
+--------------------+--------------------+-------------------------------------+

File with complete list of pins: tight_setup_hold_pins.txt
2default:defaultZ35-580h px� 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px� 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-82.770| TNS=-12957.154| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
`
%s*common2G
3Phase 4.1 Global Iteration 0 | Checksum: 14ef0a901
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:45 ; elapsed = 00:00:48 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-82.651| TNS=-12961.474| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
`
%s*common2G
3Phase 4.2 Global Iteration 1 | Checksum: 19f373705
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:45 ; elapsed = 00:00:49 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
^
%s*common2E
1Phase 4 Rip-up And Reroute | Checksum: 19f373705
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:45 ; elapsed = 00:00:49 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
]
%s*common2D
0Phase 5.1.1 Update Timing | Checksum: 164df0232
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:46 ; elapsed = 00:00:50 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-82.651| TNS=-12957.598| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px� 
[
%s*common2B
.Phase 5.1 Delay CleanUp | Checksum: 193a64f97
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:47 ; elapsed = 00:00:51 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px� 
e
%s*common2L
8Phase 5.2 Clock Skew Optimization | Checksum: 193a64f97
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:47 ; elapsed = 00:00:51 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
g
%s*common2N
:Phase 5 Delay and Skew Optimization | Checksum: 193a64f97
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:47 ; elapsed = 00:00:51 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px� 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px� 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
]
%s*common2D
0Phase 6.1.1 Update Timing | Checksum: 10723e859
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:48 ; elapsed = 00:00:53 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
�
Intermediate Timing Summary %s164*route2M
9| WNS=-82.642| TNS=-12947.841| WHS=-0.618 | THS=-22.633|
2default:defaultZ35-416h px� 
[
%s*common2B
.Phase 6.1 Hold Fix Iter | Checksum: 1e83eb571
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:48 ; elapsed = 00:00:53 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
�
�The router encountered %s pins that are both setup-critical and hold-critical and tried to fix hold violations at the expense of setup slack. Such pins are:
%s201*route2
82default:default2�
�	audio/sine_wave/phase_fun[7]_i_29/I0
	audio/sine_wave/phase_fun[7]_i_29/I1
	audio/sine_wave/phase_fun[7]_i_29/I2
	audio/sine_wave/phase_fun[7]_i_29/I3
	audio/sine_wave/phase_fun[7]_i_29/I4
	audio/resolution_reg[8]_i_6/I5
	audio/resolution_reg[8]_i_4/I5
	audio/resolution_reg[7]_i_2_comp/I3
2default:defaultZ35-468h px� 
Y
%s*common2@
,Phase 6 Post Hold Fix | Checksum: 1d77a4d9c
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:49 ; elapsed = 00:00:53 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
o

Phase %s%s
101*constraints2
7 2default:default2"
Route finalize2default:defaultZ18-101h px� 
Z
%s*common2A
-Phase 7 Route finalize | Checksum: 1ec6404fd
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:49 ; elapsed = 00:00:53 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
v

Phase %s%s
101*constraints2
8 2default:default2)
Verifying routed nets2default:defaultZ18-101h px� 
a
%s*common2H
4Phase 8 Verifying routed nets | Checksum: 1ec6404fd
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:49 ; elapsed = 00:00:53 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
r

Phase %s%s
101*constraints2
9 2default:default2%
Depositing Routes2default:defaultZ18-101h px� 
]
%s*common2D
0Phase 9 Depositing Routes | Checksum: 19795e0c5
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:50 ; elapsed = 00:00:55 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
t

Phase %s%s
101*constraints2
10 2default:default2&
Post Router Timing2default:defaultZ18-101h px� 
q

Phase %s%s
101*constraints2
10.1 2default:default2!
Update Timing2default:defaultZ18-101h px� 
\
%s*common2C
/Phase 10.1 Update Timing | Checksum: 14f3afa06
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:50 ; elapsed = 00:00:56 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
�
Estimated Timing Summary %s
57*route2M
9| WNS=-82.642| TNS=-12947.841| WHS=0.050  | THS=0.000  |
2default:defaultZ35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
_
%s*common2F
2Phase 10 Post Router Timing | Checksum: 14f3afa06
2default:defaulth px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:50 ; elapsed = 00:00:56 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
�

%s
*constraints2p
\Time (s): cpu = 00:00:50 ; elapsed = 00:00:56 . Memory (MB): peak = 2960.090 ; gain = 94.3092default:defaulth px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
9022default:default2
1022default:default2
872default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:00:522default:default2
00:00:582default:default2
2960.0902default:default2
94.3092default:defaultZ17-268h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:052default:default2
00:00:022default:default2
2960.0902default:default2
0.0002default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2y
eC:/Users/estel/laser-harp-fpga/laser_harp_test/laser_harp_test.runs/impl_1/mb_usb_hdmi_top_routed.dcp2default:defaultZ17-1381h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:082default:default2
00:00:062default:default2
2960.0902default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_drc -file mb_usb_hdmi_top_drc_routed.rpt -pb mb_usb_hdmi_top_drc_routed.pb -rpx mb_usb_hdmi_top_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
ureport_drc -file mb_usb_hdmi_top_drc_routed.rpt -pb mb_usb_hdmi_top_drc_routed.pb -rpx mb_usb_hdmi_top_drc_routed.rpx2default:defaultZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px� 
�
#The results of DRC are in file %s.
586*	vivadotcl2�
iC:/Users/estel/laser-harp-fpga/laser_harp_test/laser_harp_test.runs/impl_1/mb_usb_hdmi_top_drc_routed.rptiC:/Users/estel/laser-harp-fpga/laser_harp_test/laser_harp_test.runs/impl_1/mb_usb_hdmi_top_drc_routed.rpt2default:default8Z2-168h px� 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file mb_usb_hdmi_top_methodology_drc_routed.rpt -pb mb_usb_hdmi_top_methodology_drc_routed.pb -rpx mb_usb_hdmi_top_methodology_drc_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file mb_usb_hdmi_top_methodology_drc_routed.rpt -pb mb_usb_hdmi_top_methodology_drc_routed.pb -rpx mb_usb_hdmi_top_methodology_drc_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px� 
�
2The results of Report Methodology are in file %s.
609*	vivadotcl2�
uC:/Users/estel/laser-harp-fpga/laser_harp_test/laser_harp_test.runs/impl_1/mb_usb_hdmi_top_methodology_drc_routed.rptuC:/Users/estel/laser-harp-fpga/laser_harp_test/laser_harp_test.runs/impl_1/mb_usb_hdmi_top_methodology_drc_routed.rpt2default:default8Z2-1520h px� 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:112default:default2
00:00:082default:default2
2960.0902default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2�
�Executing : report_power -file mb_usb_hdmi_top_power_routed.rpt -pb mb_usb_hdmi_top_power_summary_routed.pb -rpx mb_usb_hdmi_top_power_routed.rpx
2default:defaulth px� 
�
Command: %s
53*	vivadotcl2�
�report_power -file mb_usb_hdmi_top_power_routed.rpt -pb mb_usb_hdmi_top_power_summary_routed.pb -rpx mb_usb_hdmi_top_power_routed.rpx2default:defaultZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 
�
�Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
9142default:default2
1032default:default2
872default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:062default:default2
00:00:052default:default2
2960.0902default:default2
0.0002default:defaultZ17-268h px� 
�
%s4*runtcl2
kExecuting : report_route_status -file mb_usb_hdmi_top_route_status.rpt -pb mb_usb_hdmi_top_route_status.pb
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -report_unconstrained -file mb_usb_hdmi_top_timing_summary_routed.rpt -pb mb_usb_hdmi_top_timing_summary_routed.pb -rpx mb_usb_hdmi_top_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px� 
�
}There are set_bus_skew constraint(s) in this design. Please run report_bus_skew to ensure that bus skew requirements are met.223*timingZ38-436h px� 
�
%s4*runtcl2l
XExecuting : report_incremental_reuse -file mb_usb_hdmi_top_incremental_reuse_routed.rpt
2default:defaulth px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
�
%s4*runtcl2l
XExecuting : report_clock_utilization -file mb_usb_hdmi_top_clock_utilization_routed.rpt
2default:defaulth px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file mb_usb_hdmi_top_bus_skew_routed.rpt -pb mb_usb_hdmi_top_bus_skew_routed.pb -rpx mb_usb_hdmi_top_bus_skew_routed.rpx
2default:defaulth px� 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px� 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px� 


End Record