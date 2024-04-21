define i64 @count(i64 %n) {
  %i_ptr = alloca i64
  %acc_ptr = alloca i64
  store i64 0, i64* %i_ptr
  store i64 0, i64* %acc_ptr
  br label %loop
loop:
  %i = load i64, i64* %i_ptr
  %reached = icmp sge i64 %i, 32
  br i1 %reached, label %ret_result, label %continue
continue:
  %acc = load i64, i64* %acc_ptr
  %curr_mask = shl i64 1, %i
  %curr_bit_wrong_pos = and i64 %n, %curr_mask
  %curr_bit = lshr i64 %curr_bit_wrong_pos, %i
  %i_inc = add i64 %i, 1
  store i64 %i_inc, i64* %i_ptr
  %status = icmp eq i64 %curr_bit, 1
  br i1 %status, label %one, label %zero
one:
  %inc = add i64 %acc, 1
  store i64 %inc, i64* %acc_ptr
  br label %loop
zero:
  br label %loop
ret_result:
  %total = load i64, i64* %acc_ptr
  ret i64 %total
}

define i64 @main(i64 %argc, i8** %argv) {
    %num = add i64 0, 1431655765
    %res = call i64 @count(i64 %num)
    ret i64 %res
}

