define i64 @isr(i64 %n) {
  %1 = alloca i64
  %acc = alloca i64
  %idx = alloca i64
  %t = alloca i64
  store i64 %n, i64* %1
  store i64 0, i64* %acc
  store i64 32, i64* %idx
  store i64 0, i64* %t
  br label %start
start:
  %2 = load i64, i64* %idx
  %3 = icmp sgt i64 %2, 0
  br i1 %3, label %then, label %end
then:
  %4 = load i64, i64* %acc
  %5 = load i64, i64* %idx
  %6 = load i64, i64* %1
  %7 = sub i64 %5, 1
  %8 = shl i64 %7, 1
  %9 = add i64 %4, %8
  %10 = mul i64 %9, %9
  store i64 %7, i64* %idx
  store i64 %9, i64* %acc
  store i64 %8, i64* %t
  %11 = icmp sgt i64 %10, %6
  br i1 %11, label %minus, label %start
minus:
  %12 = load i64, i64* %acc
  %13 = load i64, i64* %t
  %14 = sub i64 %12, %13
  store i64 %14, i64* %acc
  br label %start
end:
  %15 = load i64, i64* %acc
  ret i64 %15
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = alloca i64
  store i64 0, i64* %1
  %2 = call i64 @isr(i64 101)
  ret i64 %2
}