class destination_monitor extends uvm_monitor;

virtual destination_if.DEST_MON vif;

destination_agent_config dest_cfg;

uvm_analysis_port #(destination_trans) mon_port;

`uvm_component_utils(destination_monitor)

function new(string name="destination_monitor",uvm_component parent=null);
    super.new(name,parent);
    mon_port=new("mon_port",this);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(destination_agent_config)::get(this,"","destination_agent_config",dest_cfg))
    `uvm_fatal("destination_agent_config","cannot get() the configuration dest_cfg")
    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    vif=dest_cfg.vif;
endfunction:connect_phase

task run_phase(uvm_phase phase);
forever
    begin
        collect_data();
    end
endtask:run_phase

task collect_data();
    destination_trans xtn;
    xtn=destination_trans::type_id::create("xtn");

   // wait(vif.dest_mon_cb.read_enb==1)
    while(vif.dest_mon_cb.read_enb==0)
    @(vif.dest_mon_cb);

    @(vif.dest_mon_cb);
    xtn.header = vif.dest_mon_cb.data_out;

    xtn.payload=new[xtn.header[7:2]];
    @(vif.dest_mon_cb);
    foreach(xtn.payload[i])
    begin
        xtn.payload[i] = vif.dest_mon_cb.data_out;
        @(vif.dest_mon_cb);
    end

    xtn.parity = vif.dest_mon_cb.data_out;

    repeat(2)
    @(vif.dest_mon_cb);

    `uvm_info(get_type_name(),$sformatf("Data sampled from the Destination Monitor\n:%s",xtn.sprint()),UVM_LOW)

    mon_port.write(xtn);

endtask:collect_data

endclass:destination_monitor
