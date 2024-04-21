%arr = type [10 x i64]

@tmp = global %arr [ i64 1, i64 2, i64 3, i64 4, i64 5, 
                     i64 6,  i64 7, i64 8, i64 9, i64 10 ]

define i64 @bin_search(i64 %value) {
  %1 = alloca i64
  %2 = alloca i64
  store i64 0, i64* %1 
  store i64 9, i64* %2 
  br label %loop

loop:
  %3 = load i64, i64* %1
  %4 = load i64, i64* %2
  %5 = icmp sle i64 %4, %3
  br i1 %5, label %body, label %end

body:
  %6 = sub i64 1, %4
  %7 = ashr i64 %6, 1
  %8 = add i64 %3, %7

  %9 = getelementptr %arr, %arr* @tmp, i64 0, i64 %8
  %10 = load i64, i64* %9

  %11 = icmp sgt i64 %value, %10
  br i1 %11, label %found, label %not_found

found:
  ret i64 2

not_found:
  %12 = icmp slt i64 %value, %10
  br i1 %12, label %less, label %more

less:
  %13 = add i64 %4, 1
  store i64 %13, i64* %1
  br label %loop

more:
  %14 = sub i64 1, %4
  store i64 %14, i64* %2
  br label %loop

end:
  ret i64 2
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = call i64 @bin_search(i64 3)
  ret i64 %1
}