define i64 @popcount(i64 %x1) {
  %1 = icmp eq i64 %x1, 0
  br i1 %1, label %done, label %next
next:
  %2 = and i64 %x1, 1
  %3 = lshr i64 %x1, 1
  %4 = call i64 @popcount(i64 %3)
  %5 = add i64 %2, %4
  ret i64 %5
done:
  ret i64 0
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = call i64 @popcount(i64 19832)
  %2 = call i64 @popcount(i64 2392211394)
  %3 = call i64 @popcount(i64 892)
  %4 = add i64 %1, %2
  %5 = add i64 %3, %4
  ret i64 %5
}