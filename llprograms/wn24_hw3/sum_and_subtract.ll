%arr = type [6 x i64]
@array = global %arr [ i64 6, i64 5, i64 4, i64 3, i64 2, i64 1 ]

define i64 @sum_and_subtract() {
  %half = alloca i64
  %sum_first_half = alloca i64
  %sum_second_half = alloca i64
  %i = alloca i64
  store i64 3, i64* %half
  store i64 0, i64* %sum_first_half
  store i64 0, i64* %sum_second_half
  store i64 0, i64* %i
  
  br label %loop_first_half

loop_first_half:
  %index = load i64, i64* %i
  %is_end_first_half = icmp eq i64 %index, 3
  br i1 %is_end_first_half, label %loop_second_half, label %calc_first_half

calc_first_half:
  %arr_ptr_first_half = getelementptr %arr, %arr* @array, i64 0, i64 %index
  %val_first_half = load i64, i64* %arr_ptr_first_half
  %current_sum_first_half = load i64, i64* %sum_first_half
  %new_sum_first_half = add i64 %current_sum_first_half, %val_first_half
  store i64 %new_sum_first_half, i64* %sum_first_half
  %new_index_first_half = add i64 %index, 1
  store i64 %new_index_first_half, i64* %i
  br label %loop_first_half

loop_second_half:
  store i64 3, i64* %i
  br label %loop_second_half_check

loop_second_half_check:
  %index_second_half = load i64, i64* %i
  %is_end_second_half = icmp eq i64 %index_second_half, 6
  br i1 %is_end_second_half, label %end, label %calc_second_half

calc_second_half:
  %arr_ptr_second_half = getelementptr %arr, %arr* @array, i64 0, i64 %index_second_half
  %val_second_half = load i64, i64* %arr_ptr_second_half
  %current_sum_second_half = load i64, i64* %sum_second_half
  %new_sum_second_half = add i64 %current_sum_second_half, %val_second_half
  store i64 %new_sum_second_half, i64* %sum_second_half
  %new_index_second_half = add i64 %index_second_half, 1
  store i64 %new_index_second_half, i64* %i
  br label %loop_second_half_check

end:
  %final_sum_first_half = load i64, i64* %sum_first_half
  %final_sum_second_half = load i64, i64* %sum_second_half
  %result = sub i64 %final_sum_first_half, %final_sum_second_half
  ret i64 %result
}

define i64 @main() {
  %res = call i64 @sum_and_subtract()
  ret i64 %res
}