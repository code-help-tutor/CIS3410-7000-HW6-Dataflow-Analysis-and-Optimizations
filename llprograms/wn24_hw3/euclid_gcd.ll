define i64 @euclid_gcd(i64 %a, i64 %b) {
  %1 = alloca i64
  %2 = alloca i64
  store i64 %b, i64* %1
  store i64 %a, i64* %2
  %cmp = icmp slt i64 %b, %a
  br i1 %cmp, label %flip_order, label %correct_order

correct_order:
  %cmp1 = icmp eq i64 %a, 0
  br i1 %cmp1, label %retb, label %cont

flip_order:
  %5 = call i64 @euclid_gcd(i64 %b, i64 %a)
  ret i64 %5 

cont:
  %3 = load i64, i64* %1
  %4 = sub i64 %3, %a
  store i64 %4, i64* %1
  %cmp2 = icmp sgt i64 %4, %a
  br i1 %cmp2, label %cont, label %rec

rec:
  %5 = call i64 @euclid_gcd(i64 %4, i64 %a)
  ret i64 %5

retb:
  ret i64 %b
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = call i64 @euclid_gcd(i64 3834, i64 498)
  ret i64 %1
}

