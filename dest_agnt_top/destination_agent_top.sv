class destination_agent_top extends uvm_env;

env_config env_cfg;

destination_agent dest_agnth[];

`uvm_component_utils(destination_agent_top)

function new(string name="destination_agent_top",uvm_component parent=null);
    super.new(name,parent);
endfunction:new

function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(env_config)::get(this,"","env_config",env_cfg))
    `uvm_fatal("env_config","cannot get() the configuration env_cfg")

    dest_agnth=new[env_cfg.no_of_destination_agents];

    foreach(dest_agnth[i])
    begin
        uvm_config_db #(destination_agent_config)::set(this,$sformatf("dest_agnth[%0d]*",i),"destination_agent_config",env_cfg.dest_cfg[i]);
        dest_agnth[i]=destination_agent::type_id::create($sformatf("dest_agnth[%0d]",i),this);
    end

    super.build_phase(phase);
endfunction:build_phase

endclass:destination_agent_top
