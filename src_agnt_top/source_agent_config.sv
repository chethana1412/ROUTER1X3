class source_agent_config extends uvm_object;

`uvm_object_utils(source_agent_config)

function new(string name="source_agent_config");
super.new(name);
endfunction:new

uvm_active_passive_enum is_active;
virtual source_if vif;

endclass:source_agent_config
