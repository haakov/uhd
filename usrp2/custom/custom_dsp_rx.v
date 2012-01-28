//
// Copyright 2012 Ettus Research LLC
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

//CUSTOMIZE ME!

//The following module effects the IO of the DDC chain.
//By default, this entire module is a simple pass-through.

//To implement DSP logic before the DDC:
//Implement custom DSP between frontend and ddc input.

//To implement DSP logic after the DDC:
//Implement custom DSP between ddc output and baseband.

//To bypass the DDC with custom logic:
//Implement custom DSP between frontend and baseband.

module custom_dsp_rx
#(
    parameter DSPNO = 0,
    parameter ADCW = 24
)
(
    //control signals
    input clock, input reset, input enable,

    //settings bus
    input set_stb, input [7:0] set_addr, input [31:0] set_data,

    //full rate inputs directly from the RX frontend
    input [ADCW-1:0] frontend_i,
    input [ADCW-1:0] frontend_q,

    //full rate outputs directly to the DDC chain
    output [ADCW-1:0] ddc_in_i,
    output [ADCW-1:0] ddc_in_q,

    //strobed samples {I16,Q16} from the RX DDC chain
    input [31:0] ddc_out_sample,
    input ddc_out_strobe, //high on valid sample

    //strobbed baseband samples {I16,Q16} from this module
    output [31:0] bb_sample,
    output bb_strobe, //high on valid sample

    //debug output (optional)
    output [31:0] debug
);

    generate
        if (DSPNO==0) begin
            `ifndef RX_DSP0_MODULE
            assign ddc_in_i = frontend_i;
            assign ddc_in_q = frontend_q;
            assign bb_sample = ddc_out_sample;
            assign bb_strobe = ddc_out_strobe;
            `else
            RX_DSP0_CUSTOM_MODULE_NAME rx_dsp0_custom
            (
                .clock(clock), .reset(reset), .enable(enable),
                .set_stb(set_stb), .set_addr(set_addr), .set_data(set_data),
                .frontend_i(frontend_i), .frontend_q(frontend_q),
                .ddc_in_i(ddc_in_i), .ddc_in_q(ddc_in_q),
                .ddc_out_sample(ddc_out_sample), .ddc_out_strobe(ddc_out_strobe),
                .bb_sample(bb_sample), .bb_strobe(bb_strobe)
            );
            `endif
        end
        if (DSPNO==1) begin
            `ifndef RX_DSP1_MODULE
            assign ddc_in_i = frontend_i;
            assign ddc_in_q = frontend_q;
            assign bb_sample = ddc_out_sample;
            assign bb_strobe = ddc_out_strobe;
            `else
            RX_DSP1_CUSTOM_MODULE_NAME rx_dsp1_custom
            (
                .clock(clock), .reset(reset), .enable(enable),
                .set_stb(set_stb), .set_addr(set_addr), .set_data(set_data),
                .frontend_i(frontend_i), .frontend_q(frontend_q),
                .ddc_in_i(ddc_in_i), .ddc_in_q(ddc_in_q),
                .ddc_out_sample(ddc_out_sample), .ddc_out_strobe(ddc_out_strobe),
                .bb_sample(bb_sample), .bb_strobe(bb_strobe)
            );
            `endif
        end
        if (DSPNO==2) begin
            `ifndef RX_DSP2_MODULE
            assign ddc_in_i = frontend_i;
            assign ddc_in_q = frontend_q;
            assign bb_sample = ddc_out_sample;
            assign bb_strobe = ddc_out_strobe;
            `else
            RX_DSP2_CUSTOM_MODULE_NAME rx_dsp2_custom
            (
                .clock(clock), .reset(reset), .enable(enable),
                .set_stb(set_stb), .set_addr(set_addr), .set_data(set_data),
                .frontend_i(frontend_i), .frontend_q(frontend_q),
                .ddc_in_i(ddc_in_i), .ddc_in_q(ddc_in_q),
                .ddc_out_sample(ddc_out_sample), .ddc_out_strobe(ddc_out_strobe),
                .bb_sample(bb_sample), .bb_strobe(bb_strobe)
            );
            `endif
        end
        else begin
            `ifndef RX_DSP3_MODULE
            assign ddc_in_i = frontend_i;
            assign ddc_in_q = frontend_q;
            assign bb_sample = ddc_out_sample;
            assign bb_strobe = ddc_out_strobe;
            `else
            RX_DSP3_CUSTOM_MODULE_NAME rx_dsp3_custom
            (
                .clock(clock), .reset(reset), .enable(enable),
                .set_stb(set_stb), .set_addr(set_addr), .set_data(set_data),
                .frontend_i(frontend_i), .frontend_q(frontend_q),
                .ddc_in_i(ddc_in_i), .ddc_in_q(ddc_in_q),
                .ddc_out_sample(ddc_out_sample), .ddc_out_strobe(ddc_out_strobe),
                .bb_sample(bb_sample), .bb_strobe(bb_strobe)
            );
            `endif
        end
    endgenerate

endmodule //custom_dsp_rx
