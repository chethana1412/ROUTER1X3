class source_base_sequence extends uvm_sequence #(source_trans);

`uvm_object_utils(source_base_sequence)

function new(string name="source_base_sequence");
    super.new(name);
endfunction:new

endclass:source_base_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class source_small_sequence extends source_base_sequence;

`uvm_object_utils(source_small_sequence)

function new(string name="source_small_sequence");
    super.new(name);
endfunction:new

bit [1:0] addr;

virtual task body();

if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
`uvm_fatal("Configuration of address","cannot get() the addr value")

repeat(1)
begin
    req=source_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {header[1:0] == addr;
                                 header[7:2] inside{[1:20]};});
    finish_item(req);
end
endtask:body

endclass:source_small_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class source_medium_sequence extends source_base_sequence;

`uvm_object_utils(source_medium_sequence)

function new(string name="source_medium_sequence");
    super.new(name);
endfunction:new

bit [1:0] addr;

virtual task body();

if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
`uvm_fatal("Configuration of address","cannot get() the addr value")

repeat(1)
begin
    req=source_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {header[1:0] == addr;
                                 header[7:2] inside{[21:40]};});
    finish_item(req);
end
endtask:body

endclass:source_medium_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class source_large_sequence extends source_base_sequence;

`uvm_object_utils(source_large_sequence)

function new(string name="source_large_sequence");
    super.new(name);
endfunction:new

bit [1:0] addr;

virtual task body();

if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
`uvm_fatal("Configuration of address","cannot get() the addr value")

repeat(1)
begin
    req=source_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {header[1:0] == addr;
                                 header[7:2] inside{[41:63]};});
    finish_item(req);
end
endtask:body

endclass:source_large_sequence

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class addr0_sequence extends source_base_sequence;

`uvm_object_utils(addr0_sequence)

function new(string name="addr0_sequence");
    super.new(name);
endfunction:new

bit [1:0] addr;

virtual task body();

if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
`uvm_fatal("Configuration of address","cannot get() the addr value")

repeat(1)
begin
    req=source_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {header[1:0] == addr;
                                 header[7:2] inside{[1:20]};});
    finish_item(req);
end
endtask:body

endclass:addr0_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class addr1_sequence extends source_base_sequence;

`uvm_object_utils(addr1_sequence)

function new(string name="addr1_sequence");
    super.new(name);
endfunction:new

bit [1:0] addr;

virtual task body();

if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
`uvm_fatal("Configuration of address","cannot get() the addr value")

repeat(1)
begin
    req=source_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {header[1:0] == addr;
                                 header[7:2] inside{[1:20]};});
    finish_item(req);
end
endtask:body

endclass:addr1_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class error_sequence extends source_base_sequence;

`uvm_object_utils(error_sequence)

function new(string name="error_sequence");
    super.new(name);
endfunction:new

bit [1:0] addr;

virtual task body();

if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
`uvm_fatal("Configuration of address","cannot get() the addr value")

repeat(1)
begin
    source_trans xtn;
    xtn=source_trans::type_id::create("xtn");
    xtn.enable_parity_calc=0;

    start_item(xtn);
    if(xtn.enable_parity_calc==0)
    assert(xtn.randomize() with {header[1:0] == addr;
                                 header[7:2] inside{[1:20]};});
    finish_item(xtn);
end
endtask:body

endclass:error_sequence
