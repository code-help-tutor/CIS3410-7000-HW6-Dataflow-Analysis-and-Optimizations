%arr = type [7 x i64]
@pal_str = global %arr [ i64 1, i64 3, i64 5, i64 7, i64 5, i64 3, i64 1 ]

define i64 @is_palindrome(i64 %end_val, i64 %stop_rec) {
    %idx_ptr = alloca i64
    %end_ptr = alloca i64
    store i64 0, i64* %idx_ptr
    store i64 %end_val, i64* %end_ptr
    br label %continue
continue:
    %idx = load i64, i64* %idx_ptr
    %end = load i64, i64* %end_ptr
    %first = getelementptr %arr, %arr* @pal_str, i64 0, i64 %idx
    %last = getelementptr %arr, %arr* @pal_str, i64 0, i64 %end
    %1 = load i64, i64* %first
    %2 = load i64, i64* %last
    %check_eq = icmp eq i64 %1, %2
    br i1 %check_eq, label %loopcond, label %exitfalse
loopcond:
    %new_idx_val = add i64 %idx, 1
    %new_end_val = sub i64 %end, 1
    store i64 %new_idx_val, i64* %idx_ptr
    store i64 %new_end_val, i64* %end_ptr
    %loop_check = icmp sgt i64 %new_idx_val, %stop_rec
    br i1 %loop_check, label %exittrue, label %continue
exittrue:
    ret i64 1
exitfalse:
    ret i64 0
}

define i64 @main(i64 %argc, i8** %argv) {
  %result = call i64 @is_palindrome(i64 6, i64 3)
  ret i64 %result
}