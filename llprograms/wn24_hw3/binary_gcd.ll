define i64 @gcd(i64 %a, i64 %b) {
  %shift_a = lshr i64 %a, 1
  %shift_b = lshr i64 %b, 1
  
  %a_is_odd = and i64 %a, 1
  %b_is_odd = and i64 %b, 1
  %a_is_even = xor i64 %a_is_odd, 1
  %b_is_even = xor i64 %b_is_odd, 1
  %both_even = and i64 %a_is_even, %b_is_even
  
  %a_is_0 = icmp eq i64 %a, 0
  %b_is_0 = icmp eq i64 %b, 0

  %a_ge_b = icmp sge i64 %a, %b

  br i1 %a_is_0, label %a_is_0, label %else1
else1:
  br i1 %b_is_0, label %b_is_0, label %else2
else2:
  br i1 %both_even, label %both_even, label %else3
else3:
  br i1 %a_is_even, label %a_is_even, label %else4
else4:
  br i1 %b_is_even, label %b_is_even, label %else5
else5:
  br i1 %a_ge_b, label %a_ge_b, label %else6
else6:
  %diff = sub i64 %b, %a
  %shifted = lshr i64 %diff, 1
  %rec = call i64 @gcd(i64 %a, i64 %shifted)
  ret i64 %rec

b_is_0:
  ret i64 %a
a_is_0:
  ret i64 %b
both_even:
  %rec1 = call i64 @gcd(i64 %shift_a, i64 %shift_b)
  %rec1_shifted = shl i64 %rec1, 1
  ret i64 %rec1_shifted
a_is_even:
  %rec2 = call i64 @gcd(i64 %shift_a, i64 %b)
  ret i64 %rec2
b_is_even:
  %rec3 = call i64 @gcd(i64 %a, i64 %shift_b)
  ret i64 %rec3
a_ge_b:
  %sub = sub i64 %a, %b
  %shift_a_sub = lshr i64 %sub, 1
  %rec4 = call i64 @gcd(i64 %shift_a_sub, i64 %b)
  ret i64 %rec4
}

define i64 @main(i64 %argc, i8** %arcv) {
  %res1 = call i64 @gcd(i64 9, i64 18)
  %res2 = call i64 @gcd(i64 9, i64 21)
  %res3 = call i64 @gcd(i64 21, i64 9)
  %res4 = call i64 @gcd(i64 9, i64 18)
  %res5 = call i64 @gcd(i64 9, i64 9)
  %res6 = add i64 %res1, %res2
  %res7 = add i64 %res6, %res3
  %res8 = add i64 %res7, %res4
  %res9 = add i64 %res8, %res5
  ret i64 %res9
}
