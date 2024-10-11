class source_agent extends uvm_agent;

source_agent_config src_cfg;

source_sequencer src_seqrh;
source_driver src_drvh;
source_monitor src_monh;

`uvm_component_utils(source_agent)

function new(string name="source_agent",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",src_cfg))
    `uvm_fatal("source_agent_config","cannot get() the configuration src_cfg")

    if(src_cfg.is_active == UVM_ACTIVE)
    begin
        src_seqrh=source_sequencer::type_id::create("src_seqrh",this);
        src_drvh=source_driver::type_id::create("src_drvh",this);
    end
    
    src_monh=source_monitor::type_id::create("src_monh",this);
    
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(src_cfg.is_active == UVM_ACTIVE)
    src_drvh.seq_item_port.connect(src_seqrh.seq_item_export);
endfunction:connect_phase

endclass:source_agent
