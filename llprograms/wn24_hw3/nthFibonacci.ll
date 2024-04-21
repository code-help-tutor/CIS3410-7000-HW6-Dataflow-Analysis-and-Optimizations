%arr = type [5 x i64]

@tmp = global %arr [ i64 4, i64 9, i64 144, i64 0, i64 -1 ]

define i64 @fibonacci(i64 %n) {
  %is_zero = icmp eq i64 %n, 0
  br i1 %is_zero, label %exitzero, label %single
single:
  %is_one = icmp eq i64 %n, 1
  br i1 %is_one, label %exitone, label %recur
recur:
  %n_minus_1 = sub i64 %n, 1
  %fib_n_minus_1 = call i64 @fibonacci(i64 %n_minus_1)
  %n_minus_2 = sub i64 %n, 2
  %fib_n_minus_2 = call i64 @fibonacci(i64 %n_minus_2)
  %fib_n = add i64 %fib_n_minus_1, %fib_n_minus_2
  ret i64 %fib_n
exitzero:
  ret i64 0
exitone:
  ret i64 1
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = getelementptr %arr, %arr* @tmp, i32 0, i32 1
  %2 = load i64, i64* %1
  %3 = call i64 @fibonacci(i64 %2)
  ret i64 %3
}