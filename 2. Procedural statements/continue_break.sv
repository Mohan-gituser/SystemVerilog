// Code your testbench here
// or browse Examples
module continue_break;
  int arr[6];
  initial 
  begin
  	
    foreach(arr[i])
      arr[i]= $urandom_range(1,10);
    //continue
    for(int i=0;i<=$size(arr);i++)
    begin
      if(i==2)
        continue;
      $display("[continue]arr[%0d]=%0d",i,arr[i]);
    end
    $display("\n");
    //break
    for(int i=0;i<=$size(arr);i++)
    begin
      if(i==2)
        break;
      $display("[break]arr[%0d]=%0d",i,arr[i]);
    end
  end
  
  
endmodule