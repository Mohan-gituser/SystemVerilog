module Case_inside;
  int year;
  initial 
  begin
      year= $urandom_range(2000,2024);
    //with case inside instead of giving every possible value now you can give a ranege of values also 
    case(year) inside 
      [2000:2013] : $display("Child\tyear=%0d\tAge=%0d",year,year-2000);
      [2013:2019] : $display("Teenager\tyear=%0d\tAge=%0d",year,year-2000);
      [2019:2100] : $display("Adult\tyear=%0d\tAge=%0d",year,year-2000);
      default :$display("Invalid entry for Year\tyear=%0d\tAge=%0d",year,year-2000);
    endcase
  end
endmodule
