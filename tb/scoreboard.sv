class scoreboard extends uvm_scoreboard;

source_trans src_xtn;
destination_trans dest_xtn;

env_config env_cfg;

uvm_tlm_analysis_fifo #(source_trans) src_fifoh[];
uvm_tlm_analysis_fifo #(destination_trans) dest_fifoh[];

`uvm_component_utils(scoreboard)

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
    `uvm_fatal("env_config","cannot get() the configuration env_cfg")

    src_fifoh=new[env_cfg.no_of_source_agents];
    dest_fifoh=new[env_cfg.no_of_destination_agents];

    foreach(src_fifoh[i])
    src_fifoh[i]=new($sformatf("src_fifoh[%0d]",i),this);

    foreach(dest_fifoh[i])
    dest_fifoh[i]=new($sformatf("dest_fifoh[%0d]",i),this);
    
    super.build_phase(phase);
endfunction:build_phase

covergroup src_cg;
   ADDRESS:coverpoint src_xtn.header[1:0]{
            bins a0={0};
            bins a1={1};
            bins a2={2};}

    PAYLOAD:coverpoint src_xtn.header[7:2]{
            bins small_pkt={[1:20]};
            bins medium_pkt={[21:40]};
            bins large_pkt={[41:63]};}

    ERROR:coverpoint src_xtn.error{
          bins correct={0};
          bins wrong={1};}
endgroup:src_cg;

covergroup dest_cg;
    ADDRESS:coverpoint dest_xtn.header[1:0]{
            bins a0={0};
            bins a1={1};
            bins a2={2};}

    PAYLOAD:coverpoint dest_xtn.header[7:2]{
            bins small_pkt={[1:20]};
            bins medium_pkt={[21:40]};
            bins large_pkt={[41:63]};}
endgroup:dest_cg

function new(string name="scoreboard",uvm_component parent=null);
    super.new(name,parent);
    src_cg=new();
    dest_cg=new();
endfunction:new

task run_phase(uvm_phase phase);
forever
    begin
        fork
            begin
                src_fifoh[0].get(src_xtn);
                `uvm_info(get_type_name(),$sformatf("Data received from the Source\n:%s",src_xtn.sprint()),UVM_LOW)
                src_cg.sample();
            end
    
            begin
                fork
                    begin
                        dest_fifoh[0].get(dest_xtn);
                        `uvm_info(get_type_name(),$sformatf("Data received from the Destination[0]\n:%s",dest_xtn.sprint()),UVM_LOW)
                        compare_data(dest_xtn);
                        dest_cg.sample();
                    end
        
                    begin
                        dest_fifoh[1].get(dest_xtn);
                        `uvm_info(get_type_name(),$sformatf("Data received from the Destination[1]\n:%s",dest_xtn.sprint()),UVM_LOW)
                        compare_data(dest_xtn);
                        dest_cg.sample();
                    end

                    begin
                        dest_fifoh[2].get(dest_xtn);
                        `uvm_info(get_type_name(),$sformatf("Data received from the Destination[2]\n:%s",dest_xtn.sprint()),UVM_LOW)
                        compare_data(dest_xtn);
                        dest_cg.sample();
                    end
                join_any
                disable fork;
            end

        join
    end
endtask:run_phase
                
//task compare_data(source_trans src_xtn,destination_trans dest_xtn);
task compare_data(destination_trans dest_xtn);
    if(src_xtn.header == dest_xtn.header)
        `uvm_info(get_type_name(),"Header comparison from source and destination is successful",UVM_LOW)
    else
        `uvm_error(get_type_name(),"Header comparison from source and destination is failed")


        if(src_xtn.payload == dest_xtn.payload)
            `uvm_info(get_type_name(),"Payload comparison from source and destination is successful",UVM_LOW)
        else
            `uvm_error(get_type_name(),"Payload comparison from source and destination is failed")

    if(src_xtn.parity == dest_xtn.parity)
        `uvm_info(get_type_name(),"Parity match successful",UVM_LOW)
    else
        `uvm_error(get_type_name(),"Parity mismatch")

endtask:compare_data

endclass:scoreboard
