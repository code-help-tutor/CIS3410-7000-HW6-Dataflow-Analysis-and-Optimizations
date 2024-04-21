%arr = type [7 x i64]
@array = global %arr [ i64 2, i64 1, i64 3, i64 2, i64 2, i64 4, i64 0 ]

define i64 @count_element(i64 %n, i64 %target) {
  %i = alloca i64
  %count = alloca i64
  store i64 0, i64* %i
  store i64 0, i64* %count
  br label %loop

loop:
  %index = load i64, i64* %i
  %1 = icmp eq i64 %index, %n
  br i1 %1, label %exit, label %check

check:
  %ptr = getelementptr %arr, %arr* @array, i64 0, i64 %index
  %val = load i64, i64* %ptr
  %2 = icmp eq i64 %val, %target
  br i1 %2, label %update_count, label %update_index

update_count:
  %3 = load i64, i64* %count
  %4 = add i64 %3, 1
  store i64 %4, i64* %count
  br label %update_index

update_index:
  %5 = add i64 %index, 1
  store i64 %5, i64* %i
  br label %loop

exit:
  %6 = load i64, i64* %count
  ret i64 %6
}

define i64 @main(i64 %argc, i8** %argv) {
  %1 = call i64 @count_element(i64 7, i64 2)
  ret i64 %1
}