class destination_sequencer extends uvm_sequencer #(destination_trans);

`uvm_component_utils(destination_sequencer)

function new(string name="destination_sequencer",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

endclass:destination_sequencer
