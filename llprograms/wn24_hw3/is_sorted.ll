%arr = type [ 6 x i64 ]

@arr1 = global %arr [i64 4, i64 23, i64 23, i64 783, i64 192, i64 571]

define i64 @is_sorted(%arr* %list, i64 %end) {
    %counter = alloca i64
    store i64 0, i64* %counter
    br label %loop_header
loop_header:
    %tmp = load i64, i64* %counter
    %is_end = icmp sge i64 %tmp, %end
    br i1 %is_end, label %sorted, label %loop_body
loop_body:
    %cur_ptr = getelementptr %arr, %arr* %list, i64 0, i64 %tmp
    %cur = load i64, i64* %cur_ptr
    %next_id = add i64 %tmp, 1
    %next_ptr = getelementptr %arr, %arr* %list, i64 0, i64 %next_id
    %next = load i64, i64* %next_ptr
    %cmp = icmp sle i64 %cur, %next
    br i1 %cmp, label %continue, label %unsorted
continue:
    %update = add i64 %tmp, 1
    store i64 %update, i64* %counter
    br label %loop_header
unsorted:
    ret i64 0
sorted:
    ret i64 1
}

define i64 @main(i64 %argc, i8** %arcv) {
    %result = call i64 @is_sorted(%arr* @arr1, i64 5)
    ret i64 %result
}