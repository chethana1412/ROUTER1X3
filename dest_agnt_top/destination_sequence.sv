class destination_base_sequence extends uvm_sequence #(destination_trans);

`uvm_object_utils(destination_base_sequence)

function new(string name="destination_base_sequence");
    super.new(name);
endfunction:new

endclass:destination_base_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class valid_sequence extends destination_base_sequence;

`uvm_object_utils(valid_sequence)

function new(string name="valid_sequence");
    super.new(name);
endfunction:new

task body();
repeat(1)
begin
    req=destination_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {no_of_delays inside{[1:29]};});
    finish_item(req);
end
endtask:body

endclass:valid_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class soft_reset_sequence extends destination_base_sequence;

`uvm_object_utils(soft_reset_sequence)

function new(string name="soft_reset_sequence");
    super.new(name);
endfunction:new

task body();
repeat(1)
begin
    req=destination_trans::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {no_of_delays > 29;});
    finish_item(req);
end
endtask:body

endclass:soft_reset_sequence
