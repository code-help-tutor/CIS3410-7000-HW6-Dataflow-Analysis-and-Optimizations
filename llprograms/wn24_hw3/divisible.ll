define i64 @program(i64 %num, i64 %num_to_incr) {
  %1 = add i64 %num_to_incr, 0
  br label %loop
loop:
  %1 = add i64 %1, %num_to_incr
  %3 = icmp sge i64 %1, %num
  br i1 %3, label %done, label %loop
done:
  %4 = icmp eq i64 %1, %num
  br i1 %4, label %equal, label %neq
equal:
  ret i64 1
neq:
  ret i64 0
}
define i64 @main(i64 %argc, i8** %arcv) {
  %result = call i64 @program(i64 16, i64 4)
  ret i64 %result
}