%struct = type { [3 x i64], [3 x i64], [3 x i64] }

@gbl = global %struct { [3 x i64] [ i64 25, i64 3, i64 7 ], [3 x i64] [ i64 1, i64 70, i64 100 ], [3 x i64] [ i64 100, i64 5, i64 4 ] }

define i64 @greaterThanOrEqualTo100(i64 %sum) {
    %1 = icmp sge i64 %sum, 100
    br i1 %1, label %then, label %else
then:
  ret i64 1
else:
  ret i64 0
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = getelementptr %struct, %struct* @gbl, i32 0, i32 0, i32 0
  %first = load i64, i64* %1
  %2 = getelementptr %struct, %struct* @gbl, i32 0, i32 1, i32 1
  %second = load i64, i64* %2
  %3 = getelementptr %struct, %struct* @gbl, i32 0, i32 2, i32 2
  %third = load i64, i64* %3
  %4 = add i64 %first, %second
  %sum = add i64 %third, %4
  %geto100 = call i64 @greaterThanOrEqualTo100(i64 %sum)
  ret i64 %geto100
}
