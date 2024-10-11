interface source_if(input bit clock);

bit resetn;
bit pkt_valid;
bit [7:0] data_in;
bit error;
bit busy;

clocking src_drv_cb@(posedge clock);
default input #1 output #0;
output resetn;
output pkt_valid;
output data_in;
input busy;
endclocking:src_drv_cb

clocking src_mon_cb@(posedge clock);
default input #1 output #0;
input resetn;
input pkt_valid;
input data_in;
input busy;
input error;
endclocking:src_mon_cb

modport SRC_DRV(clocking src_drv_cb);
modport SRC_MON(clocking src_mon_cb);

endinterface:source_if
