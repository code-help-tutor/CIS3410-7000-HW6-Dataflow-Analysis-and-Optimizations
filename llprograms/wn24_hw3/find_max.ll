; define the list
%arr = type [5 x i64]
@vals = global %arr [i64 5, i64 2, i64 -1, i64 9, i64 -20]

define i64 @main(i64 %argc, i8** %argv) {
    ; get ptr to first element of array
    %initptr = getelementptr %arr, %arr* @vals, i64 0, i64 0
    ; init max to first element
    %maxptr = alloca i64
    %initmax = load i64, i64* %initptr
    store i64 %initmax, i64* %maxptr
    ; init i to 1
    %i = alloca i64
    store i64 1, i64* %i
    ; start the loop
    br label %loop
loop:
    ; get ptr to current element of array
    %i2 = load i64, i64* %i
    %ptr = getelementptr %arr, %arr* @vals, i64 0, i64 %i2
    ; load current element of array
    %val = load i64, i64* %ptr
    ; compare curr element to max element
    %max = load i64, i64* %maxptr
    %cmp = icmp sgt i64 %val, %max
    ; if curr > max, update max
    br i1 %cmp, label %update, label %next
update:
    store i64 %val, i64* %maxptr
    br label %next
next:
    ; i++
    %i3 = load i64, i64* %i
    %i4 = add i64 %i3, 1
    store i64 %i4, i64* %i
    ; while i < 5, loop
    %cmp2 = icmp slt i64 %i4, 5
    br i1 %cmp2, label %loop, label %end
end:
    ; return the maximum element
    %max2 = load i64, i64* %maxptr
    ret i64 %max2
}
