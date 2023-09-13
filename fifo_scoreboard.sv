class fifo_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp#(f_sequence_item, f_scoreboard) item_got_export;
  `uvm_component_utils(f_scoreboard)
endclass : fifo_scoreboard
