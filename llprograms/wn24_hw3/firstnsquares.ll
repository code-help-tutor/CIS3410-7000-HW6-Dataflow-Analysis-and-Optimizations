define i64 @sum_of_squares(i64 %n) {
entry:
  %sum = alloca i64
  %i = alloca i64
  store i64 0, i64* %sum
  store i64 1, i64* %i
  br label %loop
loop:                                            
  %i_val = load i64, i64* %i
  %sum_val = load i64, i64* %sum
  %cond = icmp sle i64 %i_val, %n                
  br i1 %cond, label %loop_body, label %end       
loop_body:
  %square = mul i64 %i_val, %i_val                
  %new_sum = add i64 %sum_val, %square            
  store i64 %new_sum, i64* %sum
  %next_i = add i64 %i_val, 1                   
  store i64 %next_i, i64* %i
  br label %loop                                
end:                                              
  %final_sum = load i64, i64* %sum
  ret i64 %final_sum
}

define i64 @main(i64 %argc, i8** %arcv) {
  %result = call i64 @sum_of_squares(i64 10)   
  ret i64 %result
}