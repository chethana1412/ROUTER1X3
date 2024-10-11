class env_config extends uvm_object;

`uvm_object_utils(env_config)

function new(string name="env_config");
super.new(name);
endfunction:new

int no_of_source_agents;
int no_of_destination_agents;

source_agent_config src_cfg[];
destination_agent_config dest_cfg[];

int has_scoreboard;
int has_virtual_sequencer;

endclass:env_config
