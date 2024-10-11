class source_agent_top extends uvm_env;

env_config env_cfg;

source_agent src_agnth[];

`uvm_component_utils(source_agent_top)

function new(string name="source_agent_top",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
    `uvm_fatal("env_config","cannot get() the configuration env_cfg")

    src_agnth=new[env_cfg.no_of_source_agents];

    foreach(src_agnth[i])
    begin
        uvm_config_db #(source_agent_config)::set(this,$sformatf("src_agnth[%0d]*",i),"source_agent_config",env_cfg.src_cfg[i]);
        src_agnth[i]=source_agent::type_id::create($sformatf("src_agnth[%0d]",i),this);
    end
    super.build_phase(phase);
endfunction:build_phase

endclass:source_agent_top
