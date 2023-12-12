// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Tue Dec  7 22:25:07 2021
// Host        : XiaoXin running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/files/ZJU4.1/CA/arch exp1-4
//               code/Code4Stu/Exp6/Exp6.srcs/sources_1/ip/multiplier/multiplier_sim_netlist.v}
// Design      : multiplier
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg676-2L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "multiplier,mult_gen_v12_0_16,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_16,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module multiplier
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [31:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [31:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [63:0]P;

  wire [31:0]A;
  wire [31:0]B;
  wire CLK;
  wire [63:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "6" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "63" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multiplier_mult_gen_v12_0_16 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "0" *) (* C_A_WIDTH = "32" *) (* C_B_TYPE = "0" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "32" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "6" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "63" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintex7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_16" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module multiplier_mult_gen_v12_0_16
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [31:0]A;
  input [31:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [63:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [31:0]A;
  wire [31:0]B;
  wire CLK;
  wire [63:0]P;
  wire [47:0]PCASC;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "32" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "32" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "6" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "63" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* KEEP_HIERARCHY = "soft" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  multiplier_mult_gen_v12_0_16_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(PCASC),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
ZqI7Lq/aGyAcoaejBEIk07VX9jYIkvdeTPQu9dSbDEADopcPNa+0k8THWemULZmXocovtHBV2sQ+
UG9Mr3L0hg==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
R4vPs+jPUBq40hDi8U6b9avbUk2Eb50U4A+mDDli/Y0olyqpMjS2bHK8VDjTVAFuQ+H3qih0cQYm
+ik1m47VLNMfNDfRLbftE2okRK8Kx81MRcEafr+7z29VxyL2KSwmOKbcDCEkIT1VX5y+96x7q9/g
O5zX1cVuj6hrFncQjBI=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RHGRLed4zRtfx3HaMZFysMR3Ua1JohlSUQn/uIq0QNaCK2P96ztDgqQoqe6ZQ11betfsHTRFzq/1
66ClFz6QxXME/fh2KrrXSgUZxYxwfstEZlyOThrSfu+qzCsdk0R654q7wyvVT8+Lni3RuXc5nFXx
raCVZl6qLm50r3EadUq562wDBW7iVkrMp3OgccKyJyw39sT1Jc+0IkzHuHqjKA44tfGTOOSTHNUj
YgsyeZCJS72pabS90ZfprHyjsELB7Bxw/M9/XLEV7l1LP+SCDJFvOP5dNLZDBmwYIJ5OoU7247Tk
wYu3m6ZFZNnTwWGI9SAZJyiXILRa8hVZPL9TSA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OU7rNiePgxinwm/ruLBNeniAmTTLdwPhOZ1i35IGtDWXtaPoMnsPLRF6vnJo1xeYUES1MIlBqaG4
FUeyfrnBl3ofk5rfTbxL16dBcEtA8Z/duJARcLCIBD/J+xf2VlSqIo8dG9Ww8/L9pBTHpNAObSOU
o17xArTTrLfHWXZRGfRwuRpGlTLTYOMvS1AGhQcPbXjHrlijOoz3XigDVsnyGbHfkSgOlGBCnyDS
TPebi8IC8YIl88ieW+lqTL6jl+3DZ55iTfCJKbFt/HrE1Uou1l+60xI/9h9XhrNzE5ANic5eFmyC
tdncsHEBtx+UfZhyFrHV8z72yZoLCX2rOJ+IJA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
GUoHfgebfwQKNkw122kR1rRfB4ZFf7/0xjFIvV3auOQ9RcZO2jgecvvtUAn3nocoMNPW1jFFZW0u
xgkVDSrwVJrMR/obpu7gqo1n1FD2E5BpOJV2Gwso9aZGhgTdfd0mINfCxPi4lxUYuTw1vd+iNkBH
peC7j2xzDHSu6o2S58c=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lW3oa+bS7VSdBch0q4Lk4kIel2MxeXNlqo+JkBKYCThE5vtBv3Mob32tRj6s2h8BAos9XGsKRu0r
zWpu3cgAnv8lYIL4/UPBP9T+caGqWHHoGULrLn4zuybUvPzfGPj+ANXGfPXBomTO48UgPFWBnBA2
3vlOjCiOyKLMQAUrg8RqpfdYfcnwHxk8ebrE+lZJf6NCQtrqGu/EnH7PYFH/8MSQa6yey02fLQ2J
HenzdGNam7fu3z20gETHgePuewowRrJu5bEZOzlor2RrSnb0hcSbcO4/KSA9EcbmjzBMjE5uRYAM
1y+0t4rNGr+0XAjpp8m6B8lGF+m1jIGYMJ55eQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
AYjoOGO5c2rCxRUY5RbgjfKwpMKJQrCDGPu9wzqv2ZhoT9Trod7xJlCnzNNU4kNJPTgmDf05Bkoo
EvR1hgWeTmTgCGdy7Qci0Z0L3pdxnOg9i69qsJO1qAW46sOYPeZHpvATo3irsreTIyOEcblYRdLh
Raj2T02eEhljrx1UdWXHwIq6kJGwbPaiMRXRJewJ75w53lF3nNUwTYgttUbm/hKuK4MTBvyDWlHF
UReBw5kEbERTaRF91+HNJUeoBgfLIgVhtPzX3Yzqy4fl1PxZ0BzAGNRQWfLI4TBSyl64znmxdzaS
+wcpSJ3OHZL4sBSIwGqpZ8UuNr53DWWwkd5lqw==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
F93W5rP9wRsskpVAtvm9VhlFJY5TOuivcFKT2bVYmeqxn925TMU0N0nDRJZmC+O7NbtC0kbL9Hfv
iPaQAjkvtWKCEafU216A83pjNwYVINq3GbStXAtCrvf3KbYJMQPnr6FzKWLa0RlmEqf2z1LRIJMY
cR3LKzziLGgP+oQLz6W3siXeoyqxsbDm+dasSbu2YxzGAvkTos4kX2slGrQzxYSQogS6j/MzVgIk
Vhsm3BYDbtVT5TsiHGfRfi137tS2Q9o11KN44GT+JYigwORe+GyKi5xjI6kGPl1N1DK12TlRGsgC
Wq2YWMn2ABYXE2F8mkwPOJqSaaAR0S5MMCjkaQ==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EO2KlFB8vWgjeXvua8SEZL2APl0WfdPtqoF/0VTjBDZhkKh8T7GBS9tSSrCin7kHRBUGF6hOUPK2
V0JQtp4yW7c3oVbMN2ePIV7UdtkAszA2lMqOqeKJbWn0TfxRWL5adG+jGlhhYEbaT6tkCGPbbtbk
y5Kew5kT3RyGP8Rb0tim3cGvqi2BdBxqdc5Sb+Vyj0havZUyZo1AsjuLnNukDIYIrPCtqOY22MTp
VlNOr/u23OIMx+xx7Z4aOvZacPCxfg662ljyHetf5a0wu31WI6zf/69lkXq1iWJtHgEJn2iDpIWs
bSWDEtGgKAFHGKVAoc0vIGP3aPG6DIsqRyQ90Q==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
okI7cVrJi4Ojc+P/D+2UAREhcG7ZmXyIiHjFOBJkg7o1IAi/91zaWiVfD0zzwD9iqVc4lH2/sT6z
7lV1Ol+DBCFJm63k9D+oHInzIzMbJDHFOM8GvBEF2HmYLe/vfMbUKqT+Rrtm1QqDFzBA1nQnh08N
5XqaeYi+jCL+i71R4u6/AVtPdFR0/r3I3I5SLfiUul2eBCLztfFjDUrkRoypEfeyPf4MwKehYQHP
OEcOT7KSA1QQUPEkw4/gXjwY9VTjJ4RUMOzpIpmT8VkdfMu3XP+siprY7Gk4QmXrmOjgiXyAj6S3
hbXL94MJQonMgSME+343xVbVSmP1G6NBMKTbtg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pZPL0qdi+hh+l98qC+3skzLrpyjlXOMqWiqixOFj93d2Z0ZycLBfnqjlOaS2OdUqc+4WVyt1sfHk
FHaAiOLRhRTt6SMoTxILZ5+AeaUd4au3NapYl0o2UAy5pHovvX4RbmtsIg16MYc/M1wGyB43+JSA
nJqL9F8dsJT0ILS06bMIx+OorVilRhX7/R3drV+L9mWBUgShjzGRS3xwDMEcHE8okKeg3HyK95Rf
HkxTv8/oNsyhsq5I4czcsIgKjlo6P2McpqsLVRwKzR8bYhlSiQGuOFRCfrS/aEqNKMJ8A/WuaAAf
EkiEDBUqbx+/xG9/nSNWiSh2gUTg5NTIGkl7cA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 57488)
`pragma protect data_block
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
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
