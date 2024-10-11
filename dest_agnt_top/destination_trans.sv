class destination_trans extends uvm_sequence_item;

`uvm_object_utils(destination_trans)

function new(string name="destination_trans");
    super.new(name);
endfunction:new

bit [7:0] header;
bit [7:0] payload[];
bit [7:0] parity;
bit valid_out;
bit read_enb;

rand bit [5:0] no_of_delays;

function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("header",this.header,8,UVM_DEC);

    foreach(payload[i])
    begin
        printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);
    end

    printer.print_field("parity",this.parity,8,UVM_DEC);

    printer.print_field("valid_out",this.valid_out,1,UVM_BIN);

    printer.print_field("read_enb",this.read_enb,1,UVM_BIN);

endfunction:do_print

endclass:destination_trans
