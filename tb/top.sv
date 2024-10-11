module  top;

import router_pkg::*;
import uvm_pkg::*;

bit clock;

always
    #5 clock=~clock;

source_if in(clock);
destination_if in0(clock);
destination_if in1(clock);
destination_if in2(clock);

router_top DUV(.clock(clock),.resetn(in.resetn),
               .pkt_valid(in.pkt_valid),.data_in(in.data_in),
               .err(in.error),.busy(in.busy),.vld_out_0(in0.valid_out),
               .vld_out_1(in1.valid_out), .vld_out_2(in2.valid_out),
               .read_enb_0(in0.read_enb),.read_enb_1(in1.read_enb),
               .read_enb_2(in2.read_enb),.data_out_0(in0.data_out),
               .data_out_1(in1.data_out),.data_out_2(in2.data_out));


initial

    begin

        `ifdef VCS
            $fsdbDumpvars(0, top);
        `endif

        uvm_config_db #(virtual source_if)::set(null,"*","vif",in);

        uvm_config_db #(virtual destination_if)::set(null,"*","vif_0",in0);
        uvm_config_db #(virtual destination_if)::set(null,"*","vif_1",in1);
        uvm_config_db #(virtual destination_if)::set(null,"*","vif_2",in2);

        run_test();

    end

    property stable_data;
    @(posedge clock) in.busy |=> $stable(in.data_in);
    endproperty

    property busy_check;
    @(posedge clock) $rose(in.pkt_valid) -> in.busy;
    endproperty

    property valid_signal;
    @(posedge clock) $rose(in.pkt_valid) |-> ##3(in0.valid_out | in1.valid_out | in2.valid_out);
    endproperty

    property read_enb0;
    @(posedge clock) in0.valid_out |-> ##[1:29]in0.read_enb;
    endproperty

    property read_enb1;
    @(posedge clock) in1.valid_out |-> ##[1:29]in1.read_enb;
    endproperty

    property read_enb2;
    @(posedge clock) in2.valid_out |-> ##[1:29]in2.read_enb;
    endproperty

    property read_enb0_low;
    @(posedge clock) $fell(in0.valid_out) |=> $fell(in0.read_enb);
    endproperty

    property read_enb1_low;
    @(posedge clock) $fell(in1.valid_out) |=> $fell(in1.read_enb);
    endproperty

    property read_enb2_low;
    @(posedge clock) $fell(in2.valid_out) |=> $fell(in2.read_enb);
    endproperty

A1: cover property (stable_data);

A2: cover property (busy_check);

A3: cover property (valid_signal);

A4: cover property (read_enb0);

A5: cover property(read_enb1);

A6: cover property (read_enb2);

A7: cover property(read_enb0_low);

A8: cover property(read_enb1_low);

A9: cover property(read_enb2_low);

    C1: assert property(stable_data)
        $display("Assertion is successful for stable_data");
        else
        $display("Assertion is failed for stable_data");

    C2: assert property(busy_check)
        $display("Assertion is successful for busy_check");
        else
        $display("Assertion is failed for busy_check");

    C3: assert property(valid_signal)
        $display("Assertion is successful for valid_signal");
        else
        $display("Assertion is failed for valid_signal");
 
    C4: assert property(read_enb0)
        $display("Assertion is successful for read_enb0");
        else
        $display("Assertion is failed for read_enb0");

    C5: assert property(read_enb1)
        $display("Assertion is successful for read_enb1");
        else
        $display("Assertion is failed for read_enb1");

    C6: assert property(read_enb2)
        $display("Assertion is successful for read_enb2");
        else
        $display("Assertion is failed for read_enb2");

    C7: assert property(read_enb0_low)
        $display("Assertion is successful for read_enb0_low");
        else
        $display("Assertion is failed for read_enb0_low");

    C8: assert property(read_enb1_low)
        $display("Assertion is successful for read_enb1_low");
        else
        $display("Assertion is failed for read_enb1_low");

    C9: assert property(read_enb2_low)
        $display("Assertion is successful for read_enb2_low");
        else
        $display("Assertion is failed for read_enb2_low");
    
endmodule:top
