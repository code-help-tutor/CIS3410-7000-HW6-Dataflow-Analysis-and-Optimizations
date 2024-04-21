%vector = type [ 3 x i64 ]
%callback = type i64(i64, i64)*

@point = global %vector [i64 1, i64 2, i64 3]

define i64 @accumulator(i64 %acc, i64 %cur) {
    %square = mul i64 %cur, %cur
    %new = add i64 %acc, %square
    ret i64 %new
}

define i64 @fold_left(%callback %fn, i64 %initial, %vector* %head) {
    %acc_ptr = alloca i64
    store i64 %initial, i64* %acc_ptr
    %index_ptr = alloca i64
    store i64 0, i64* %index_ptr
    br label %loop
loop:
    %index = load i64, i64* %index_ptr
    %cur_ptr = getelementptr %vector, %vector* %head, i64 0, i64 %index
    %acc = load i64, i64* %acc_ptr
    %cur = load i64, i64* %cur_ptr
    %new_acc = call i64 %fn(i64 %acc, i64 %cur)
    store i64 %new_acc, i64* %acc_ptr
    %new_index = add i64 %index, 1
    store i64 %new_index, i64* %index_ptr
    %1 = icmp eq i64 %new_index, 3
    br i1 %1, label %ending, label %loop
ending:
    %result = load i64, i64* %acc_ptr
    ret i64 %result
}

define i64 @main(i64 %argc, i8** %argv) {
    %result = call i64 @fold_left(%callback @accumulator, i64 0, %vector* @point)
    ret i64 %result
}