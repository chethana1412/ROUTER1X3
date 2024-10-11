interface destination_if(input bit clock);

bit valid_out;
bit read_enb;
bit [7:0] data_out;

clocking dest_drv_cb@(posedge clock);
default input #1 output #0;
output read_enb;
input valid_out;
endclocking:dest_drv_cb

clocking dest_mon_cb@(posedge clock);
default input #1 output #0;
input read_enb;
input valid_out;
input data_out;
endclocking:dest_mon_cb

modport DEST_DRV(clocking dest_drv_cb);
modport DEST_MON(clocking dest_mon_cb);

endinterface:destination_if
