%struct = type { i64, [5000 x i64], i64 }

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = call i64 @foo(i64 5)
  ret i64 %1
}

define i64 @foo(i64 %n) {
  br label %start
start:
  %1 = alloca %struct
  ret i64 1
none: 
  %2 = alloca %struct
  ret i64 2
}