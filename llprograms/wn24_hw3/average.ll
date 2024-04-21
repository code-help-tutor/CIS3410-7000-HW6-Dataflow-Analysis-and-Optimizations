%arr = type [3 x i64]
@array = global %arr [i64 1, i64 2, i64 3]

define i64 @calculate_average()
{
  %sum = alloca i64
  store i64 0, i64* %sum

  ; Loop through the array to calculate the sum.
  %i = alloca i64
  store i64 0, i64* %i
  br label %loop

loop:
  %i_val = load i64, i64* %i
  %is_end = icmp sge i64 %i_val, 3
  br i1 %is_end, label %calculate, label %loop_body

loop_body:
  %current_ptr = getelementptr %arr, %arr* @array, i64 0, i64 %i_val
  %current_val = load i64, i64* %current_ptr
  %current_sum = load i64, i64* %sum
  %new_sum = add i64 %current_sum, %current_val
  store i64 %new_sum, i64* %sum

  ; Increment i.
  %new_i = add i64 %i_val, 1
  store i64 %new_i, i64* %i
  br label %loop

calculate:
  ; Calculate average without division using mul.
  %final_sum = load i64, i64* %sum

  ; a * x = 1 mod m
  ; a = 43691, m = 3
  ; 43691 * x = 1 mod 3
  ; x = 2
  ; 43691 * 2 = 87382
  ; 87382 = 1 mod 3
  %average = mul i64 %final_sum, 43691
  ret i64 %average
}

define i64 @main()
{
  %result = call i64 @calculate_average()
  ret i64 %result
}
