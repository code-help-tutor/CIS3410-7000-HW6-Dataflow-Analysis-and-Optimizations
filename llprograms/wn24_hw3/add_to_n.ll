@n = global i64 20


define i64 @sum() {
entry:
  %sum = alloca i64
  %i = alloca i64
  store i64 0, i64* %sum
  store i64 1, i64* %i
  br label %cond


cond:
  %i_val = load i64, i64* %i
  %n_val = load i64, i64* @n
  %cmp = icmp sle i64 %i_val, %n_val
  br i1 %cmp, label %body, label %end


body:
  %sum_val = load i64, i64* %sum
  %new_sum = add i64 %sum_val, %i_val
  store i64 %new_sum, i64* %sum
  %new_i = add i64 %i_val, 1
  store i64 %new_i, i64* %i
  br label %cond


end:
  %res = load i64, i64* %sum
  ret i64 %res
}


define i64 @main() {
entry:
  %res = call i64 @sum()
  ret i64 %res
}
