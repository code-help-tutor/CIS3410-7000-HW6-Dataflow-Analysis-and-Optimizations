@base = global i64 2
@power = global i64 7

define i64 @power_rec(i64 %p) {
  %cmp = icmp sle i64 %p, 1
  br i1 %cmp, label %ret1, label %recurse
ret1:
  %b = load i64, i64* @base
  ret i64 %b
recurse:
  %1 = sub i64 %p, 1
  %2 = call i64 @power_rec(i64 %1)
  %b1 = load i64, i64* @base
  %3 = mul i64 %b1, %2
  ret i64 %3
}

define i64 @main(i64 %argc, i8** %arcv) {
  %p = load i64, i64* @power
  %cmp1 = icmp eq i64 %p, 0
  br i1 %cmp1, label %exit0, label %continue0
exit0:
  ret i64 1
continue0:
  %cmp2 = icmp slt i64 %p, 0
  br i1 %cmp2, label %exit_undef, label %continue1
exit_undef:
  ret i64 0
continue1:
  %1 = call i64 @power_rec(i64 %p)
  ret i64 %1
}