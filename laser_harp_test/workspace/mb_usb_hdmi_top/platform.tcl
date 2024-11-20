# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\estel\laser_harp_test\workspace\mb_usb_hdmi_top\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\estel\laser_harp_test\workspace\mb_usb_hdmi_top\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {mb_usb_hdmi_top}\
-hw {C:\Users\estel\laser_harp_test\mb_usb_hdmi_top.xsa}\
-out {C:/Users/estel/laser_harp_test/workspace}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform generate -quick
platform clean
platform generate
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains standalone_microblaze_0 
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform clean
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform clean
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform clean
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate
platform clean
platform clean
platform clean
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform clean
platform generate
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
platform active {mb_usb_hdmi_top}
platform config -updatehw {C:/Users/estel/project/laser-harp-fpga/laser_harp_test/mb_usb_hdmi_top.xsa}
platform generate -domains 
