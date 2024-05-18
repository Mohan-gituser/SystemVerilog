class Function_inside_Class_outside_class;
  extern function void ext_disp();
    function void class_inside_disp();
      $display("Hello from Function declared inside of the class");
    endfunction
endclass
function void Function_inside_Class_outside_class::ext_disp();
  $display("Hello from Function declared outside of the class using scope resolution operator :: ");
endfunction
    
module All_about_a_Function;
	
  // function starts with function keyword and ends with endfunction
  // beloe void specifying the return type of the function 
  // function can return one value 
  // if a function is not returning a value then we will use void 
  // we can pass arguments to the function 1. defualt arguments 2. positional arguments 3. pass by reference 4. const variable pass
  // by default function is automatic for every function call inside function variables are newly created 
  function void display_func();
    $display("[display_func-Void return type]Hello from  function");
  endfunction
  
  function int function_name_return();
  	function_name_return = 100;
  endfunction
  
  
  function void default_args(string str="Function",int a=1,b=20);
    int sum;
    sum = a+b;
    $display("[%0s] Sum= %0d + %0d = %0d",str,a,b,sum);
    a=0;
    b=0;
  endfunction
  
  
  function automatic void pass_by_ref(input string str="Function",ref int a, b);
    int sum;
    sum = a+b;
    $display("[%0s] Sum= %0d + %0d = %0d",str,a,b,sum);
    a=0;
    b=0;
  endfunction
  
  function automatic void pass_by_ref_const(input string str="Function",const ref int a,ref int b);
    int sum;
    sum = a+b;
    $display("[%0s] Sum= %0d + %0d = %0d",str,a,b,sum);
//     a=0; // uncomment and run to see the compilation error
//     b=0; // comment and uncomment - no compilation error - but with comment no modification on b variable after function is executed (outside of function ) - with un comminning result in same modification outside the function also
  endfunction
  
  function int return_func(input int a);
    // we do a lot of modification and at the end we will return data with return data specified type here it is int in the declaration
    return_func= a+10;
    // below both returns are same 
//     return a+10; 
    return return_func;
  endfunction

  
  function automatic int automatic_disp(input int c);
	c++;
    return c;
  endfunction
  
  function static  int static_disp(input int a);
    a=10;
    return a;
  endfunction
  
  
  Function_inside_Class_outside_class handle;
  initial 
  begin
	int c,d;
    int sum ;
    static int e; // static variable
    int f ; // non static variable
	//========basic function call with void return type
    $display("\nHello from Function");
    display_func();
    
    //========function name itself will act like a return type variable and we can get the value from this name 
    $display("\nfunction name itself will act like a return type observe the below function it is returning the integer and printing in the terminal");
    $display("Returned value from the [function_name_return] function",function_name_return());
    
    //========function call with default arguments
    $display("\nDefault Args");
    default_args("Default Args");
    
    // Pass by position with value
    $display("\nPass by Value");
    default_args("Pass by value with direct  value",10,20);
	c=11;
    d=31;
    default_args("Pass by value with Variable",c,d);
    default_args("Pass by value with Variable and excludind default variable",,d);// we can skip the default variable pass also during call if we not passing then by default deafult value will be taken here a defalut value is 1
    
    // function call pass by name - order can be interchange
    $display("\nPass by name");
    default_args("Pass by name with passing arguments at different position",.b(11),.a(10));
    default_args(.b(23),.a(40),.str("Pass by name with passing arguments at different position"));
    default_args(.b(16),.str("Pass by name with passing arguments at different position and excluding the default variable ")); // we can skip the default variable pass also during call if we not passing then by default deafult value will be taken here a defalut value is 1
    
    //different combination of default value and by name is also possible
    $display("\ncombination of default value and by name is also possible");
    default_args(,c,.b(10));//string is default , c is by value=11 , b is by name 
    
    //pass by ref 
    
    $display("\nPass By Reference \n[Before]c=%0d\td=%0d",c,d);
    pass_by_ref("Passby reference",c,d);
    $display("[After] [Pass by reference-function wont create a copy of the variable instead it will use the same strogae for both actual and formal arguments]We haven't modifed c and d even inside pass_by_ref function still c & d values are modified due to ref keyword\n[After]c=%0d\td=%0d\n",c,d); // even though the actual and variable name are different since we have used ref same copy will be shared and any modification inside function to the variable will be visible after function is executed also that is why for the above case we will get c and d values as 0 this modification hase been done in the function declaration
    
    
    //pass by reference with const - to avoid any change on  the reference varible leads to compilation errors
    // sometime we need to pass arguments directly with same storage but we dont expect any modification to be happen on this variable inside function decaration in such scenarios we will append this const keyword to variable 
    // we can add ref for only automatic functions 
    $display("\nPass By Reference with const ");
    c=11;
    d=12;
    pass_by_ref_const("Passby reference Const",c,d); // go to function declaration and uncomment modification on a and run the code to observe the compilation error 
    // we can add const ref for only automatic functions
    
    $display("\nfunction usage inside and outside of the class");
    handle = new(); // memory allocation 
    handle.class_inside_disp; // accessing class declared inside of the class using . operator with the help of handle object of class type Function_inside_Class_outside_class
    handle.ext_disp; // accessing class declared outside of the class
    
    
    // we can use the function in expression and directly in print statements also 
    $display("\nreturned value from Function=%0d",function_name_return());
    $display("\nreturned value from Function+20=%0d",function_name_return()+20);
    
    sum = sum + function_name_return(); // expressions
    $display("\n[function in Expressions sum+function_name_return()]Sum=%0d",sum);
    
    // we can get the value from a function either with function name itself or with return keyword we will return the data from the function 
    $display("\n[Return data from function with return keyword in function]\t%0d",return_func(100));
    
    //Automatic Function
    //by default function and task are automatic - every variable declared inside the function is a local variabe only it wont be shared accross other calls 
    //allocates unique, stacked storage for each function call 
    $display("\nAutomatic function");
    c=11;
    $display("[automatic function -return data c=%0d]",automatic_disp(c));
    $display("[automatic functon after c =%0d]",c); // no modification of storage seperate allocation will happen for automatic functions
    
    $display("\n[Static Function]data rxd:%0d\ne is static variable it is legal static function can contain only static variables",static_disp(e)); // e is static variable it is legal static function can contain only static variables  - non static variable inside static function leads to compilation errors
    

    
//    notes:
// 	  by default task and function are static inside module and automatic inside class
//    By defalut direction is input 
//    By default if you havent mentioned any data type in the declaration arguments it wil treat as a logic data type  
  end
endmodule





