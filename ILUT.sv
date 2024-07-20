module ILUT(
  input[3:0] IPtr,
  output logic[7:0] Immediate);

  always_comb case(IPtr)
	4'd0:  Jump = 0   ; 
	4'd1:  Jump = 1   ;
	4'd2:  Jump = -1  ;
	4'd3:  Jump = 2   ;
	4'd4:  Jump = -2  ; 
	4'd5:  Jump = 16  ; 
	4'd6:  Jump = 32  ; 
	4'd7:  Jump = 64  ;
	4'd8:  Jump = 128 ;
	4'd9:  Jump = 0   ;
	4'd10: Jump = 0   ;
	4'd11: Jump = 0   ;
	4'd12: Jump = 0   ;
	4'd13: Jump = 0   ;
	4'd14: Jump = 0   ;
	4'd15: Jump = 0   ;
  endcase

endmodule
