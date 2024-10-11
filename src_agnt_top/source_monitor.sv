class source_monitor extends uvm_monitor;

source_agent_config src_cfg;
virtual source_if.SRC_MON vif;

uvm_analysis_port #(source_trans) mon_port;

`uvm_component_utils(source_monitor)

function new(string name="source_monitor",uvm_component parent=null);
super.new(name,parent);
mon_port=new("mon_port",this);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(source_agent_config)::get(this,"","source_agent_config",src_cfg))
    `uvm_fatal("source agent config","cannot get() the configuration src_cfg")
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    vif=src_cfg.vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
forever
    collect_data();
endtask:run_phase

task collect_data();
    source_trans xtn;
    xtn=source_trans::type_id::create("xtn");
    
    //wait(vif.src_mon_cb.busy==0)
    //wait(vif.src_mon_cb.pkt_valid==1)
    while(vif.src_mon_cb.busy==1)
    @(vif.src_mon_cb);

    while(vif.src_mon_cb.pkt_valid==0)
    @(vif.src_mon_cb);

    xtn.header = vif.src_mon_cb.data_in;
    @(vif.src_mon_cb);

    xtn.payload=new[xtn.header[7:2]];
    foreach(xtn.payload[i])
    begin
        //wait(vif.src_mon_cb.busy==0)
        while(vif.src_mon_cb.busy==1)
        @(vif.src_mon_cb);

        xtn.payload[i] = vif.src_mon_cb.data_in;
        @(vif.src_mon_cb);
    end

    //wait(vif.src_mon_cb.busy==0)
    //wait(vif.src_mon_cb.pkt_valid==0)

    while(vif.src_mon_cb.busy==1)
    @(vif.src_mon_cb);

    while(vif.src_mon_cb.pkt_valid==1)
    @(vif.src_mon_cb);
    
    xtn.parity = vif.src_mon_cb.data_in;

    repeat(2)
    @(vif.src_mon_cb);
    xtn.error = vif.src_mon_cb.error;

   `uvm_info(get_type_name(),$sformatf("Data sampled from the Source Monitor\n:%s",xtn.sprint()),UVM_LOW)

    mon_port.write(xtn);

endtask:collect_data

endclass:source_monitor
