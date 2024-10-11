class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

source_sequencer src_seqrh[];
destination_sequencer dest_seqrh[];

env_config env_cfg;

`uvm_component_utils(virtual_sequencer)

function new(string name="virtual_sequencer",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
    `uvm_fatal("env_config","cannot get() the configuration env_cfg")
    
    src_seqrh=new[env_cfg.no_of_source_agents];
    dest_seqrh=new[env_cfg.no_of_destination_agents];

    super.build_phase(phase);
endfunction:build_phase

endclass:virtual_sequencer
