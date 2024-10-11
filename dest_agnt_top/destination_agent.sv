class destination_agent extends uvm_agent;

destination_agent_config dest_cfg;

destination_sequencer dest_seqrh;
destination_driver dest_drvh;
destination_monitor dest_monh;

`uvm_component_utils(destination_agent)

function new(string name="destination_agent",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(destination_agent_config)::get(this,"","destination_agent_config",dest_cfg))
    `uvm_fatal("destination_agent_config","cannot get() the configuration dest_cfg")

    if(dest_cfg.is_active == UVM_ACTIVE)
    begin
        dest_seqrh=destination_sequencer::type_id::create("dest_seqrh",this);
        dest_drvh=destination_driver::type_id::create("dest_drvh",this);
    end
    
    dest_monh=destination_monitor::type_id::create("dest_monh",this);

    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(dest_cfg.is_active == UVM_ACTIVE)
    dest_drvh.seq_item_port.connect(dest_seqrh.seq_item_export);
endfunction:connect_phase

endclass:destination_agent
