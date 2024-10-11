class base_test extends uvm_test;

source_agent_config src_cfg_t[];
destination_agent_config dest_cfg_t[];
env_config env_cfg;

int no_of_source_agents=1;
int no_of_destination_agents=3;
int has_scoreboard=1;
int has_virtual_sequencer=1;

environment envh;

`uvm_component_utils(base_test)

function new(string name="base_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    env_cfg=env_config::type_id::create("env_cfg");

    src_cfg_t=new[no_of_source_agents];
    env_cfg.src_cfg=new[no_of_source_agents];

    foreach(src_cfg_t[i])
        begin
            src_cfg_t[i]=source_agent_config::type_id::create($sformatf("src_cfg_t[%0d]",i));
            src_cfg_t[i].is_active=UVM_ACTIVE;
            
            if(!uvm_config_db #(virtual source_if)::get(this,"","vif",src_cfg_t[i].vif))
            `uvm_fatal("vif config","cannot get() the interface vif from uvm_config_db")

            env_cfg.src_cfg[i]=src_cfg_t[i];
        end

    dest_cfg_t=new[no_of_destination_agents];
    env_cfg.dest_cfg=new[no_of_destination_agents];

    foreach(dest_cfg_t[i])
    begin
        dest_cfg_t[i]=destination_agent_config::type_id::create($sformatf("dest_cfg_t[%0d]",i));
        dest_cfg_t[i].is_active=UVM_ACTIVE;

        if(!uvm_config_db #(virtual destination_if)::get(this,"",$sformatf("vif_%0d",i),dest_cfg_t[i].vif))
        `uvm_fatal("vif config","cannot get() the interface vif from uvm_config_db")

        env_cfg.dest_cfg[i]=dest_cfg_t[i];
    end

    env_cfg.no_of_source_agents=no_of_source_agents;
    env_cfg.no_of_destination_agents=no_of_destination_agents;
    env_cfg.has_scoreboard=has_scoreboard;
    env_cfg.has_virtual_sequencer=has_virtual_sequencer;
    uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);

    envh=environment::type_id::create("envh",this);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction:end_of_elaboration_phase

endclass:base_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class small_sequence_test extends base_test;

bit [1:0] addr;

virtual_small_sequence vsmall_seqh;

`uvm_component_utils(small_sequence_test)

function new(string name="small_sequence_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr={$random}%3;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);
    
    phase.raise_objection(this);

    vsmall_seqh=virtual_small_sequence::type_id::create("vsmall_seqh");

    vsmall_seqh.start(envh.vseqrh);
    #100;

    phase.drop_objection(this);
endtask:run_phase

endclass:small_sequence_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class medium_sequence_test extends base_test;

bit [1:0] addr;

virtual_medium_sequence vmedium_seqh;

`uvm_component_utils(medium_sequence_test)

function new(string name="medium_sequence_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr={$random}%3;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

    phase.raise_objection(this);

    vmedium_seqh=virtual_medium_sequence::type_id::create("vmedium_seqh");

    vmedium_seqh.start(envh.vseqrh);
    #100;

    phase.drop_objection(this);
endtask:run_phase

endclass:medium_sequence_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class large_sequence_test extends base_test;

bit [1:0] addr;

virtual_large_sequence vlarge_seqh;

`uvm_component_utils(large_sequence_test)

function new(string name="large_sequence_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr={$random}%3;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

    phase.raise_objection(this);

    vlarge_seqh=virtual_large_sequence::type_id::create("vlarge_seqh");

    vlarge_seqh.start(envh.vseqrh);
    #100;

    phase.drop_objection(this);
endtask:run_phase

endclass:large_sequence_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class addr0_test extends base_test;

bit [1:0] addr;

virtual_addr0_sequence vaddr0_seqh;

`uvm_component_utils(addr0_test)

function new(string name="addr0_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr=2'b0;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

    phase.raise_objection(this);

    vaddr0_seqh=virtual_addr0_sequence::type_id::create("vaddr0_seqh");

    vaddr0_seqh.start(envh.vseqrh);
    #100;

    phase.drop_objection(this);
endtask:run_phase

endclass:addr0_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class addr1_test extends base_test;

bit [1:0] addr;

virtual_addr1_sequence vaddr1_seqh;

`uvm_component_utils(addr1_test)

function new(string name="addr1_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr=2'b1;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

    phase.raise_objection(this);

    vaddr1_seqh=virtual_addr1_sequence::type_id::create("vaddr1_seqh");

    vaddr1_seqh.start(envh.vseqrh);
    #100;

    phase.drop_objection(this);
endtask:run_phase

endclass:addr1_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class soft_reset_test extends base_test;

bit [1:0] addr;

virtual_soft_reset_sequence vsoft_rst_seqh;

`uvm_component_utils(soft_reset_test)

function new(string name="soft_reset_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr={$random}%3;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

    phase.raise_objection(this);

    vsoft_rst_seqh=virtual_soft_reset_sequence::type_id::create("vsoft_rst_seqh");

    vsoft_rst_seqh.start(envh.vseqrh);
    #100;

    phase.drop_objection(this);
endtask:run_phase

endclass:soft_reset_test

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class error_test extends base_test;

bit [1:0] addr;

virtual_error_sequence verror_seqh;

`uvm_component_utils(error_test)

function new(string name="error_test",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction:build_phase

function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
endfunction:end_of_elaboration_phase

task run_phase(uvm_phase phase);
    addr={$random}%3;
    uvm_config_db #(bit[1:0])::set(this,"*","bit[1:0]",addr);

    phase.raise_objection(this);

    verror_seqh=virtual_error_sequence::type_id::create("verror_seqh");

    verror_seqh.start(envh.vseqrh);
    #100;
    
    phase.drop_objection(this);
endtask:run_phase

endclass:error_test
