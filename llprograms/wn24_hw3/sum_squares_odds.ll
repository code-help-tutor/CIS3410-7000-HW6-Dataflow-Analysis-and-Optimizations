%arr = type [10 x i64]

@array = global %arr [ i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7, i64 8, i64 9, i64 10 ]

define i64 @sum_of_squares_of_odds() {
  %i = alloca i64
  %sum = alloca i64
  store i64 0, i64* %i
  store i64 0, i64* %sum
  br label %loop
loop:
  %index = load i64, i64* %i
  %is_end = icmp eq i64 %index, 10
  br i1 %is_end, label %end, label %calc
calc:
  %arr_ptr = getelementptr %arr, %arr* @array, i64 0, i64 %index
  %val = load i64, i64* %arr_ptr
  %is_odd = and i64 %val, 1
  %is_odd_cond = icmp eq i64 %is_odd, 1
  br i1 %is_odd_cond, label %add_square, label %next_iteration

add_square:
  %val_squared = mul i64 %val, %val
  %current_sum = load i64, i64* %sum
  %new_sum = add i64 %current_sum, %val_squared
  store i64 %new_sum, i64* %sum
  br label %next_iteration

next_iteration:
  %new_index = add i64 %index, 1
  store i64 %new_index, i64* %i
  br label %loop

end:
  %final_sum = load i64, i64* %sum
  ret i64 %final_sum
}

define i64 @main(i64 %argc, i8** %argv) {
  %res = call i64 @sum_of_squares_of_odds()
  ret i64 %res
}