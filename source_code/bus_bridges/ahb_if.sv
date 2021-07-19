// File name:   ahb_if.vh
// Created:     9/10/2015
// Author:      Erin Rasmussen
// Version      1.0
// Description: Interface for fully specified AMBA 3 AHB-Lite

interface ahb_if();
   logic [1:0] HTRANS;
   logic  [1:0] HRESP;
   //logic [1:0] HRESP;			JOHN CHANGED THIS
   logic [2:0] HSIZE;
   logic [31:0] HADDR;
   logic [31:0] HWDATA;
   logic 	HWRITE, HREADY,HREADYOUT, HSEL, HMASTLOCK;
   logic [31:0] HRDATA;
   logic [2:0] HBURST;
   logic [3:0] HPROT;

   modport ahb_s (
     input HTRANS, HWRITE, HADDR, HWDATA, HSIZE, HSEL, HBURST, HREADY,
           HPROT, HMASTLOCK,
     output HREADYOUT, HRESP, HRDATA
   );

   modport ahb_m (
     input HREADY, HRESP, HRDATA,
     output HTRANS, HWRITE, HADDR, HWDATA, HSIZE, HBURST, HPROT, HMASTLOCK
   );

   modport ahb_m_i (
     output HREADY, HRESP, HRDATA,
     input HTRANS, HWRITE, HADDR, HWDATA, HSIZE, HBURST, HPROT, HMASTLOCK
   );   

endinterface // ahb_if
