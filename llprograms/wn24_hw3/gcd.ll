define i64 @gcd(i64 %a, i64 %b) {
entry:
  br label %loop

loop:
  %b_eq_0 = icmp eq i64 %b, 0
  br i1 %b_eq_0, label %exit, label %continue

continue:
  %a_mod_b = srem i64 %a, %b
  %new_a = select i1 %b_eq_0, i64 %a, i64 %b
  %new_b = select i1 %b_eq_0, i64 0, i64 %a_mod_b
  %a = phi i64 [%new_a, %continue], [%a, %entry]
  %b = phi i64 [%new_b, %continue], [%b, %entry]
  br label %loop

exit:
  ret i64 %a
}

define i64 @main() {
entry:
  %a = alloca i64
  %b = alloca i64
  store i64 48, i64* %a
  store i64 18, i64* %b
  %a_val = load i64, i64* %a
  %b_val = load i64, i64* %b
  %gcd_result = call i64 @gcd(i64 %a_val, i64 %b_val)
  ret i64 %gcd_result
}