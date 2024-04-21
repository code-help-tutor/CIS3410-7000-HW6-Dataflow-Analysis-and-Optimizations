%arr = type [5 x i64]

@arr1 = global %arr [i64 5, i64 3, i64 12, i64 7, i64 1]

define i64 @find_max(%arr* %list, i64 %size) {
    %max_val = alloca i64
    store i64 0, i64* %max_val
    %counter = alloca i64
    store i64 0, i64* %counter
    br label %loop_header

loop_header:
    %tmp = load i64, i64* %counter
    %is_end = icmp sge i64 %tmp, %size
    br i1 %is_end, label %max_found, label %loop_body

loop_body:
    %cur_ptr = getelementptr %arr, %arr* %list, i64 0, i64 %tmp
    %cur = load i64, i64* %cur_ptr
    %max_so_far = load i64, i64* %max_val
    %cmp = icmp sgt i64 %cur, %max_so_far
    br i1 %cmp, label %update_max, label %continue

update_max:
    store i64 %cur, i64* %max_val
    br label %continue

continue:
    %update = add i64 %tmp, 1
    store i64 %update, i64* %counter
    br label %loop_header

max_found:
    %result = load i64, i64* %max_val
    ret i64 %result
}

define i64 @main(i64 %argc, i8** %arcv) {
    %result = call i64 @find_max(%arr* @arr1, i64 5)
    ret i64 %result
}