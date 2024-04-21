%arr = type [6 x i64]

@tmp = global %arr [ i64 10, i64 3, i64 -5, i64 -6, i64 2, i64 1]

define i64 @maxdif() {
  %max = alloca i64
  %min = alloca i64
  %i = alloca i64
  store i64 0, i64* %i
  store i64 -100, i64* %max
  store i64 100, i64* %min
  br label %loop

loop:
  %i_val = load i64, i64* %i
  %cmp = icmp slt i64 %i_val, 6
  br i1 %cmp, label %body, label %end

body:
  %element_ptr = getelementptr %arr, %arr* @tmp, i64 0, i64 %i_val
  %element = load i64, i64* %element_ptr
  %max_val = load i64, i64* %max
  %min_val = load i64, i64* %min
  %new_max_cond = icmp sgt i64 %element, %max_val
  br i1 %new_max_cond, label %new_max, label %check_min

new_max:
  store i64 %element, i64* %max
  br label %check_min

check_min:
  %new_min_cond = icmp slt i64 %element, %min_val
  br i1 %new_min_cond, label %new_min, label %update_i

new_min:
  store i64 %element, i64* %min
  br label %update_i

update_i:
  %next_i = add i64 %i_val, 1
  store i64 %next_i, i64* %i
  br label %loop

end:
  %max_final = load i64, i64* %max
  %min_final = load i64, i64* %min
  %diff = sub i64 %max_final, %min_final
  ret i64 %diff
}

define i64 @main(i64 %argc, i8** %argv) {
  %diff = call i64 @maxdif()
  ret i64 %diff
}
