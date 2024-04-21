%arr = type [5 x i64]

@array = global %arr [ i64 1, i64 2, i64 3, i64 4, i64 5 ]

define i64 @sum(i64 %n) {
  %i = alloca i64
  %sum = alloca i64
  store i64 0, i64* %i
  store i64 0, i64* %sum
  br label %loop
loop:
  %index = load i64, i64* %i
  %is_end = icmp eq i64 %index, %n
  br i1 %is_end, label %end, label %calc
calc:
  %arr_ptr = getelementptr %arr, %arr* @array, i64 0, i64 %index
  %val = load i64, i64* %arr_ptr
  %current_sum = load i64, i64* %sum
  %new_sum = add i64 %current_sum, %val
  store i64 %new_sum, i64* %sum
  %new_index = add i64 %index, 1
  store i64 %new_index, i64* %i
  br label %loop
end:
  %final_sum = load i64, i64* %sum
  ret i64 %final_sum
}

define i64 @main(i64 %argc, i8** %argv) {
  %res = call i64 @sum(i64 5)
  ret i64 %res
}