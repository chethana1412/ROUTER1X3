class environment extends uvm_env;

env_config env_cfg;

source_agent_top src_agnt_toph;
destination_agent_top dest_agnt_toph;

virtual_sequencer vseqrh;
scoreboard sbh;

`uvm_component_utils(environment)

function new(string name="environment",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
    `uvm_fatal("env_config","cannot get() the configuration env_cfg")

    src_agnt_toph=source_agent_top::type_id::create("src_agnt_toph",this);
    
    dest_agnt_toph=destination_agent_top::type_id::create("dest_agnt_toph",this);

    if(env_cfg.has_virtual_sequencer)
    vseqrh=virtual_sequencer::type_id::create("vseqrh",this);

    if(env_cfg.has_scoreboard)
    sbh=scoreboard::type_id::create("sbh",this);

    super.build_phase(phase);
endfunction:build_phase

function void connect_phase(uvm_phase phase);
    if(env_cfg.has_virtual_sequencer)
    begin
        for(int i=0;i<env_cfg.no_of_source_agents;i++)
        vseqrh.src_seqrh[i]=src_agnt_toph.src_agnth[i].src_seqrh;

        for(int k=0;k<env_cfg.no_of_destination_agents;k++)
        vseqrh.dest_seqrh[k]=dest_agnt_toph.dest_agnth[k].dest_seqrh;
    end

    if(env_cfg.has_scoreboard)
    begin
        for(int i=0;i<env_cfg.no_of_source_agents;i++)
        src_agnt_toph.src_agnth[i].src_monh.mon_port.connect(sbh.src_fifoh[i].analysis_export);
        
        for(int k=0;k<env_cfg.no_of_destination_agents;k++)
        dest_agnt_toph.dest_agnth[k].dest_monh.mon_port.connect(sbh.dest_fifoh[k].analysis_export);
    end
endfunction:connect_phase

endclass:environment
