onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/clk
add wave -noupdate /system_tb/nRst
add wave -noupdate -expand -group Operands -color {Cornflower Blue} -radix binary /system_tb/m_sequence
add wave -noupdate -expand -group Operands -color {Cornflower Blue} -radix binary /system_tb/DUT/sample
add wave -noupdate -expand -group Operation /system_tb/start
add wave -noupdate -expand -group Operation /system_tb/DUT/peak_found
add wave -noupdate -expand -group Operation -color Coral /system_tb/tb_state
add wave -noupdate -expand -group Operation -color {Medium Slate Blue} -radix binary /system_tb/DUT/port_output
add wave -noupdate -expand -group Operation -color {Medium Slate Blue} -radix decimal /system_tb/DUT/sum
add wave -noupdate -expand -group Operation -color {Medium Slate Blue} /system_tb/DUT/peak
add wave -noupdate -expand -group {Register File} /system_tb/DUT/rfif/WEN
add wave -noupdate -expand -group {Register File} -color Wheat /system_tb/DUT/rfif/wsel
add wave -noupdate -expand -group {Register File} -color Wheat /system_tb/DUT/rfif/wdat
add wave -noupdate -expand -group {Register File} -color Wheat -subitemconfig {{/system_tb/DUT/RF/register[31]} {-color Wheat} {/system_tb/DUT/RF/register[30]} {-color Wheat} {/system_tb/DUT/RF/register[29]} {-color Wheat} {/system_tb/DUT/RF/register[28]} {-color Wheat} {/system_tb/DUT/RF/register[27]} {-color Wheat} {/system_tb/DUT/RF/register[26]} {-color Wheat} {/system_tb/DUT/RF/register[25]} {-color Wheat} {/system_tb/DUT/RF/register[24]} {-color Wheat} {/system_tb/DUT/RF/register[23]} {-color Wheat} {/system_tb/DUT/RF/register[22]} {-color Wheat} {/system_tb/DUT/RF/register[21]} {-color Wheat} {/system_tb/DUT/RF/register[20]} {-color Wheat} {/system_tb/DUT/RF/register[19]} {-color Wheat} {/system_tb/DUT/RF/register[18]} {-color Wheat} {/system_tb/DUT/RF/register[17]} {-color Wheat} {/system_tb/DUT/RF/register[16]} {-color Wheat} {/system_tb/DUT/RF/register[15]} {-color Wheat} {/system_tb/DUT/RF/register[14]} {-color Wheat} {/system_tb/DUT/RF/register[13]} {-color Wheat} {/system_tb/DUT/RF/register[12]} {-color Wheat} {/system_tb/DUT/RF/register[11]} {-color Wheat} {/system_tb/DUT/RF/register[10]} {-color Wheat} {/system_tb/DUT/RF/register[9]} {-color Wheat} {/system_tb/DUT/RF/register[8]} {-color Wheat} {/system_tb/DUT/RF/register[7]} {-color Wheat} {/system_tb/DUT/RF/register[6]} {-color Wheat} {/system_tb/DUT/RF/register[5]} {-color Wheat} {/system_tb/DUT/RF/register[4]} {-color Wheat} {/system_tb/DUT/RF/register[3]} {-color Wheat} {/system_tb/DUT/RF/register[2]} {-color Wheat} {/system_tb/DUT/RF/register[1]} {-color Wheat} {/system_tb/DUT/RF/register[0]} {-color Wheat}} /system_tb/DUT/RF/register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23177 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {45403 ps}
