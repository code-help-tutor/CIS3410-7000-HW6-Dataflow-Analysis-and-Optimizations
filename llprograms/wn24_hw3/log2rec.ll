@n = global i64 76891

define i64 @log2rec(i64 %n) {
  %1 = icmp sle i64 %n, 1
  br i1 %1, label %ret0, label %cont

cont:
  %2 = ashr i64 %n, 1
  %3 = call i64 @log2rec(i64 %2)
  %4 = add i64 1, %3
  ret i64 %4

ret0:
  ret i64 0
}

define i64 @main(i64 %argc, i8** %argv) {
  %1 = load i64, i64* @n
  %2 = call i64 @log2rec(i64 %1)
  ret i64 %2
}