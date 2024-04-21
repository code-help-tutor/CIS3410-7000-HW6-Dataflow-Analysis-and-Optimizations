%arr = type [5 x i64]

@myarray1 = global %arr [i64 1, i64 2, i64 3, i64 4, i64 5]  
@myarray2 = global %arr [i64 1, i64 2, i64 3, i64 4, i64 5]

define i64 @main(i64 %argc, i8** %argv) {  
  %answer = alloca i64  
  store i64 0, i64* %answer  
  %val = call i64 @dot_product(i64 5)  
  store i64 val, i64* %answer  
  ret i64 %answer  
}

define i64 @dot_product(i64 %size) {  
    %i = alloca i64  
    store i64 0, i64* %i  
    %sum = alloca i64  
    store i64 0, i64* %sum  
    br label %bound_check

bound_check:  
    %index = load i64, i64* %i  
    %0 = icmp eq i64 %index, %size  
    br i1 %0, label %end, label %compute

compute:  
    %arr1_ptr_to_i = getelementptr %arr, %arr* @myarray1, i64 0, i64 %index  
    %arr1_at_i = load i64, i64* %arr1_ptr_to_i  
    %arr2_ptr_to_i = getelementptr %arr, %arr* @myarray2, i64 0, i64 %index  
    %arr2_at_i = load i64, i64* %arr2_ptr_to_i  
    %add_to_sum = mul i64 %arr1_at_i, %arr2_at_i  
    %inc_sum = add i64 %sum, %add_to_sum  
    store i64 %inc_sum, i64* %sum  
    br label %increment

increment:  
    %inc_i = add i64 %i, 1  
    store i64 %inc_i, i64* %i  
    br label %bound_check

end:  
    %result = load i64, i64* %sum  
    ret i64 %result  
} 