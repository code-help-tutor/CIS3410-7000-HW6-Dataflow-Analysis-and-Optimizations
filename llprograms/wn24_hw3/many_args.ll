define i64 @foo(i64 %a0, i64 %a1, i64 %a2, i64 %a3, i64 %a4, i64 %a5, i64 %a6, i64 %a7) {
  %1 = add i64 %a6, %a7
  ret i64 %1
}

define i64 @main(i64 %argc, i8** %argv) {
  %1 = call i64 @foo(i64 0, i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 7)
  ret i64 %1
}