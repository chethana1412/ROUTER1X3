class virtual_sequence_base extends uvm_sequence #(uvm_sequence_item);

source_sequencer src_seqrh[];
destination_sequencer dest_seqrh[];

virtual_sequencer vseqrh;

env_config env_cfg;

`uvm_object_utils(virtual_sequence_base)

function new(string name="virtual_sequence_base");
    super.new(name);
endfunction:new

task body();
    if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",env_cfg))
    `uvm_fatal("env_config","cannot get() the configuration env_cfg")

    src_seqrh=new[env_cfg.no_of_source_agents];
    dest_seqrh=new[env_cfg.no_of_destination_agents];

    assert($cast(vseqrh,m_sequencer))
    else
        begin
            `uvm_error(get_full_name(),"virtual sequencer pointer case failed")
        end

    foreach(src_seqrh[i])
    src_seqrh[i]=vseqrh.src_seqrh[i];

    foreach(dest_seqrh[i])
    dest_seqrh[i]=vseqrh.dest_seqrh[i];
endtask:body

endclass:virtual_sequence_base

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_small_sequence extends virtual_sequence_base;

bit [1:0] addr;

source_small_sequence src_small_seqh;
valid_sequence vld_seqh;

`uvm_object_utils(virtual_small_sequence)

function new(string name="virtual_small_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();
    
    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"cannot get the address")

    src_small_seqh=source_small_sequence::type_id::create("src_small_seqh");

    vld_seqh=valid_sequence::type_id::create("vld_seqh");

    fork
        begin
            src_small_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            vld_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            vld_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            vld_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_small_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_medium_sequence extends virtual_sequence_base;

bit [1:0] addr;

source_medium_sequence src_medium_seqh;
valid_sequence vld_seqh;

`uvm_object_utils(virtual_medium_sequence)

function new(string name="virtual_medium_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"cannot get() the address")

    src_medium_seqh=source_medium_sequence::type_id::create("src_medium_seqh");

    vld_seqh=valid_sequence::type_id::create("vld_seqh");

    fork
        begin
            src_medium_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            vld_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            vld_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            vld_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_medium_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_large_sequence extends virtual_sequence_base;

bit [1:0] addr;

source_large_sequence src_large_seqh;
valid_sequence vld_seqh;

`uvm_object_utils(virtual_large_sequence)

function new(string name="virtual_large_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"cannot get() the address")

    src_large_seqh=source_large_sequence::type_id::create("src_large_seqh");

    vld_seqh=valid_sequence::type_id::create("vld_seqh");

    fork
        begin
            src_large_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            vld_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            vld_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            vld_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_large_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_addr0_sequence extends virtual_sequence_base;

bit [1:0] addr;

addr0_sequence addr0_seqh;
valid_sequence vld_seqh;

`uvm_object_utils(virtual_addr0_sequence)

function new(string name="virtual_addr0_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"cannot get() the address")

    addr0_seqh=addr0_sequence::type_id::create("addr0_seqh");
    vld_seqh=valid_sequence::type_id::create("vld_seqh");

    fork
        begin
            addr0_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            vld_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            vld_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            vld_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_addr0_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_addr1_sequence extends virtual_sequence_base;

bit [1:0] addr;

addr1_sequence addr1_seqh;
valid_sequence vld_seqh;

`uvm_object_utils(virtual_addr1_sequence)

function new(string name="virtual_addr1_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"cannot get() the address")

    addr1_seqh=addr1_sequence::type_id::create("addr1_seqh");
    vld_seqh=valid_sequence::type_id::create("vld_seqh");

    fork
        begin
            addr1_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            vld_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            vld_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            vld_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_addr1_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_soft_reset_sequence extends virtual_sequence_base;

source_small_sequence src_small_seqh;
soft_reset_sequence sft_rst_seqh;

bit [1:0] addr;

`uvm_object_utils(virtual_soft_reset_sequence)

function new(string name="virtual_soft_reset_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();

    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"cannot get the address")

    src_small_seqh=source_small_sequence::type_id::create("src_small_seqh");
    sft_rst_seqh=soft_reset_sequence::type_id::create("sft_rst_seqh");

    fork
        begin
            src_small_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            sft_rst_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            sft_rst_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            sft_rst_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_soft_reset_sequence

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class virtual_error_sequence extends virtual_sequence_base;

error_sequence err_seqh;
valid_sequence vld_seqh;

bit [1:0] addr;

`uvm_object_utils(virtual_error_sequence)

function new(string name="virtual_error_sequence");
    super.new(name);
endfunction:new

task body();
    super.body();
    if(!uvm_config_db #(bit[1:0])::get(null,get_full_name(),"bit[1:0]",addr))
    `uvm_fatal(get_type_name(),"Cannot get() the address")

    err_seqh=error_sequence::type_id::create("err_seqh");
    vld_seqh=valid_sequence::type_id::create("vld_seqh");

    fork
        begin
            err_seqh.start(src_seqrh[0]);
        end

        begin
            if(addr==2'b00)
            vld_seqh.start(dest_seqrh[0]);

            if(addr==2'b01)
            vld_seqh.start(dest_seqrh[1]);

            if(addr==2'b10)
            vld_seqh.start(dest_seqrh[2]);
        end
    join
endtask:body

endclass:virtual_error_sequence
