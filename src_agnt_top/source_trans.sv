class source_trans extends uvm_sequence_item;

rand bit [7:0] header;
rand bit [7:0] payload[];
bit [7:0] parity;
bit resetn;
bit pkt_valid;
bit error;
bit busy;
bit enable_parity_calc=1;

`uvm_object_utils(source_trans)

function new(string name="source_trans");
super.new(name);
endfunction:new

constraint valid_addr{header[1:0] != 2'b11;}
constraint valid_length{header[7:2] != 0;}
constraint valid_size{payload.size == header[7:2];}

function void post_randomize();
if(enable_parity_calc==1)
begin
    parity=header^0;

    foreach(payload[i])
    begin
        parity=parity^payload[i];
    end
end
else
    parity={$random}%2==1;
endfunction:post_randomize

function void do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("header",this.header,8,UVM_DEC);

    foreach(payload[i])
    printer.print_field($sformatf("payload[%0d]",i),this.payload[i],8,UVM_DEC);

    printer.print_field("parity",this.parity,8,UVM_DEC);
    
    printer.print_field("resetn",this.resetn,1,UVM_BIN);
    printer.print_field("pkt_valid",this.pkt_valid,1,UVM_BIN);
    printer.print_field("error",this.error,1,UVM_BIN);
    printer.print_field("busy",this.busy,1,UVM_BIN);
endfunction:do_print

endclass:source_trans
