package router_pkg;

import uvm_pkg::*;

typedef enum{UVM_ACTIVE,UVM_PASSIVE} uvm_active_passive_enum;

`include "uvm_macros.svh"
`include "source_trans.sv"
`include "destination_trans.sv"
`include "source_agent_config.sv"
`include "destination_agent_config.sv"
`include "env_config.sv"
`include "source_sequencer.sv"
`include "destination_sequencer.sv"
`include "source_driver.sv"
`include "destination_driver.sv"
`include "source_monitor.sv"
`include "destination_monitor.sv"
`include "source_agent.sv"
`include "destination_agent.sv"
`include "source_agent_top.sv"
`include "destination_agent_top.sv"
`include "virtual_sequencer.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "source_sequence.sv"
`include "destination_sequence.sv"
`include "virtual_sequence.sv"
`include "test.sv"

endpackage
