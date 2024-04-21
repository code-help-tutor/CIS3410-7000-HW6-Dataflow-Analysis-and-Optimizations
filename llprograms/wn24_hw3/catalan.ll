define i64 @catalan(i64 %n)
{
 %z_or_o = icmp sle i64 %n, 1
 br i1 %z_or_o, label %basecase, label %cat
cat:
    %i = alloca i64
    store i64 0, i64* %i
    %result = alloca i64
    store i64 0, i64* %result
    br label %loop
loop:
    %ival1 = load i64, i64* %i
    %cmp1 = icmp slt i64 %ival1, %n
    br i1 %cmp1, label %doloop, label %end
doloop:
    %ival2 = load i64, i64* %i
    %sub_from_n = sub i64 %n, %ival2
    %sub_1_from_n = sub i64 %sub_from_n, 1
    %firstcall = call i64 @catalan(i64 %ival2)
    %secondcall = call i64 @catalan(i64 %sub_1_from_n)
    %multiply = mul i64 %firstcall, %secondcall
    %load_accum = load i64, i64* %result
    %add_to_result = add i64 %load_accum, %multiply
    store i64 %add_to_result, i64* %result
    br label %increment
increment:
    %ival3 = load i64, i64* %i
    %inc = add i64 %ival3, 1
    store i64 %inc, i64* %i
    br label %loop
basecase:
 ret i64 1
end:
    %done = load i64, i64* %result
    ret i64 %done
}

define i64 @main(i64 %argc, i8** %argv) 
{
 %work = call i64 @catalan(i64 6)
 ret i64 %work
}