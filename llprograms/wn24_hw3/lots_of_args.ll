define i64 @sub_and_mul(i64 %a, i64 %b, i64 %c, i64 %d, i64 %e, i64 %f, i64 %g, i64 %h) {
  %sub_result = sub i64 %g, %h
  %mul_result = mul i64 %sub_result, %f
  %add_result = add i64 %mul_result, %e
  ret i64 %add_result
}

define i64 @main(i64 %argc, i8** %argv) {
  %result = call i64 @sub_and_mul(i64 1, i64 2, i64 3, i64 4, i64 5, i64 6, i64 100, i64 1)
  ret i64 %result
}
