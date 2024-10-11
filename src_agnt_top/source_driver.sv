class source_driver extends uvm_driver #(source_trans);

source_agent_config src_cfg;
virtual source_if.SRC_DRV vif;

`uvm_component_utils(source_driver)

function new(string name="source_driver",uvm_component parent=null);
    super.new(name,parent);
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
    @(vif.src_drv_cb);
    vif.src_drv_cb.resetn <= 1'b0;
    repeat(2)
    @(vif.src_drv_cb);
    vif.src_drv_cb.resetn <= 1'b1;
    
    forever
        begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
endtask:run_phase

task send_to_dut(source_trans xtn);
    `uvm_info(get_type_name(),$sformatf("Data to be driven from the Source Driver to the DUT:%s",xtn.sprint()),UVM_LOW)
    //wait(vif.src_drv_cb.busy==0)
    while(vif.src_drv_cb.busy==1)
    @(vif.src_drv_cb);

    vif.src_drv_cb.pkt_valid <= 1'b1;
    vif.src_drv_cb.data_in <= xtn.header;

    @(vif.src_drv_cb);
    foreach(xtn.payload[i])
    begin
        //wait(vif.src_drv_cb.busy==0)
        while(vif.src_drv_cb.busy==1)
        @(vif.src_drv_cb);

        vif.src_drv_cb.data_in <= xtn.payload[i];
        @(vif.src_drv_cb);
    end

    vif.src_drv_cb.pkt_valid <= 1'b0;
    vif.src_drv_cb.data_in <= xtn.parity;
endtask:send_to_dut

endclass:source_driver
