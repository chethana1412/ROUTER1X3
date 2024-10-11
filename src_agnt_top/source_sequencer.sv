class source_sequencer extends uvm_sequencer #(source_trans);

`uvm_component_utils(source_sequencer)

function new(string name="source_sequencer",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

endclass:source_sequencer
