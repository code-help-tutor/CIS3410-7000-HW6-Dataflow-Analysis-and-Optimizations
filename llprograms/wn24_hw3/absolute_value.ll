define i32 @abs(i32 %x) {
  %is_neg = icmp slt i32 %x, 0
  br i1 %is_neg, label %if_neg, label %if_pos

if_neg:
  %neg_x = mul i32 %x, -1
  ret i32 %neg_x

if_pos:
  ret i32 %x
}

define i32 @main() {
  %1 = call i32 @abs(i32 -5)
  ret i32 %1
}