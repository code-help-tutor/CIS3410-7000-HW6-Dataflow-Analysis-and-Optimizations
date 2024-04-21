%arr = type [3 x i64]

@array1 = global %arr [ i64 1, i64 2, i64 3]
@array2 = global %arr [ i64 2, i64 3, i64 4]

define i64 @fnc(i64 %len) {
  %index = alloca i64
  %prod = alloca i64
  store i64 0, i64* %index
  store i64 1, i64* %prod
  br label %check

check:
  %curr_index = load i64, i64* %index
  %is_finished = icmp eq i64 %curr_index, %len
  br i1 %is_finished, label %done, label %body

body:
  %arr1_ptr = getelementptr %arr, %arr* @array1, i64 0, i64 %curr_index
  %arr2_ptr = getelementptr %arr, %arr* @array2, i64 0, i64 %curr_index
  %val1 = load i64, i64* %arr1_ptr
  %val2 = load i64, i64* %arr2_ptr
  %curr_prod = load i64, i64* %prod
  %temp_prod = mul i64 %val1, %val2
  %new_prod= mul i64 %temp_prod, %curr_prod
  store i64 %new_prod, i64* %prod
  %to_add = load i64, i64* %index
  %new_index = add i64 %to_add, 1
  store i64 %new_index, i64* %index
  br label %check
  
done:
  %to_ret = load i64, i64* %prod
  ret i64 %to_ret
}

define i64 @main(i64 %argc, i8** %argv) {
  %res = call i64 @fnc(i64 3)
  ret i64 %res
}