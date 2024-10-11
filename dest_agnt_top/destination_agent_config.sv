class destination_agent_config extends uvm_object;

`uvm_object_utils(destination_agent_config)

function new(string name="destination_agent_config");
super.new(name);
endfunction:new

uvm_active_passive_enum is_active;
virtual destination_if vif;

endclass:destination_agent_config
