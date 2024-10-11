class destination_driver extends uvm_driver #(destination_trans);

virtual destination_if.DEST_DRV vif;

destination_agent_config dest_cfg;

`uvm_component_utils(destination_driver)

function new(string name="destination_driver",uvm_component parent=null);
    super.new(name,parent);
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
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
endtask:run_phase

task send_to_dut(destination_trans xtn);

//wait(vif.dest_drv_cb.valid_out==1)
while(vif.dest_drv_cb.valid_out==0)
@(vif.dest_drv_cb);

repeat(xtn.no_of_delays)
@(vif.dest_drv_cb);
    vif.dest_drv_cb.read_enb <= 1'b1;

//wait(vif.dest_drv_cb.valid_out==0)
while(vif.dest_drv_cb.valid_out==1)
@(vif.dest_drv_cb);

@(vif.dest_drv_cb);
    vif.dest_drv_cb.read_enb <= 1'b0;

endtask:send_to_dut

endclass:destination_driver    
