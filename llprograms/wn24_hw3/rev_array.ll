%arr = type [5 x i64]
@array = global %arr [i64 7, i64 5, i64 1, i64 3, i64 8]

define i64 @rev(i64 %arr_size) {

    %curr_idx = alloca i64      ; tracks lower bound of sort
    store i64 -1, i64* %curr_idx
    
    %end_idx = alloca i64       ; tracks current min idx
    store i64 %arr_size, i64* %end_idx

    ; Start of selection sort algorithm
    br label %loop

loop:
    ; Calc val of next curr_idx (lower bound)
    %val1 = load i64, i64* %curr_idx
    %next_idx = add i64 1, %val1
    store i64 %next_idx, i64* %curr_idx

    ; Calc val of next curr_idx (upper bound)
    %val2 = load i64, i64* %end_idx
    %prev_idx = add i64 -1, %val2
    store i64 %prev_idx, i64* %end_idx

    ; Are we at the middle
    %cmp1 = icmp eq i64 %prev_idx, %next_idx
    br i1 %cmp1, label %return, label %swap

swap:

    ; Find ptrs of where to swap
    %tmpA = load i64, i64* %end_idx
    %ptrA = getelementptr %arr, %arr* @array, i64 0, i64 %tmpA
    %valA = load i64, i64* %ptrA
    %tmpB = load i64, i64* %curr_idx
    %ptrB = getelementptr %arr, %arr* @array, i64 0, i64 %tmpB
    %valB = load i64, i64* %ptrB

    ; Swap values & store
    store i64 %valB, i64* %ptrA
    store i64 %valA, i64* %ptrB
    
    br label %loop

return:
    %result_ptr = getelementptr %arr, %arr* @array, i64 0, i64 0
    %first_elt = load i64, i64* %result_ptr
    ret i64 %first_elt
}

; Program: uses selection sort to index sort an array of length 5
define i64 @main(i64 %argc, i8** %arcv) {
    %end = call i64 @rev(i64 5)
    ret i64 %end
}