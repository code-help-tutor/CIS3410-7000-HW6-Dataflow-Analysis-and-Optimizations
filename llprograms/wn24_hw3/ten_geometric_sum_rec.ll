%arr = type [10 x i64]
@dp = global %arr [ i64 1, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0]

define i64 @rec_m (i64 %m, i64 %n){
    %1 = icmp eq i64 %n, 0
    br i1 %1, label %base, label %rec
base:
    %r1 = getelementptr %arr, %arr* @dp, i32 0, i32 0
    %r = load i64, i64* %r1
    ret i64 %r

rec:
    %n1 = sub i64 %n, 1
    %r2 = call i64 @rec_m(i64 %m, i64 %n1)
    %ptr1 = getelementptr %arr, %arr* @dp, i32 0, i64 %n1
    %ptr2 = getelementptr %arr, %arr* @dp, i32 0, i64 %n
    %val = load i64, i64* %ptr1
    %newVal = mul i64 %m, %val
    store i64 %newVal, i64* %ptr2
    %retu = add i64 %newVal, %r2
    ret i64 %retu
}

define i64 @main(i64 %argc, i8** %arcv) {
  %result = call i64 @rec_m(i64 2, i64 5)
  ret i64 %result
}
