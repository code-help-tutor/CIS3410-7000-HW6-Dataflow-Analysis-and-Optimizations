%arr = type [6 x i64]
@array = global %arr [ i64 1, i64 2, i64 3, i64 4, i64 5, i64 6 ]

define i64 @numOfEvens() {
    %evens = alloca i64
    store i64 0, i64* %evens

    %arrSize = alloca i64
    store i64 6, i64* %arrSize

    %i = alloca i64
    store i64 0, i64* %i
    br label %loop_i_cond

loop_i_cond:
    %i_val = load i64, i64* %i
    %cmp_i = icmp slt i64 %i_val, 6
    br i1 %cmp_i, label %loop_i_body, label %loop_end

loop_i_body:
    %arr_i = getelementptr %arr, %arr* @array, i64 0, i64 %i_val
    %val_i = load i64, i64* %arr_i
    %is_odd = and i64 %val_i, 1
    %is_even = xor i64 %is_odd, 1
    %cmp_even = icmp eq i64 %is_even, 1
    br i1 %cmp_even, label %increment_evens, label %loop_i_update

increment_evens:
    %evens_val = load i64, i64* %evens
    %evens_inc = add i64 %evens_val, 1
    store i64 %evens_inc, i64* %evens
    br label %loop_i_update

loop_i_update:
    %i_val_new = add i64 %i_val, 1
    store i64 %i_val_new, i64* %i
    br label %loop_i_cond

loop_end:
    %result = load i64, i64* %evens
    ret i64 %result
}

define i64 @main(i64 %argc, i8** %arcv) {
    %result = call i64 @numOfEvens()
    ret i64 %result
}
