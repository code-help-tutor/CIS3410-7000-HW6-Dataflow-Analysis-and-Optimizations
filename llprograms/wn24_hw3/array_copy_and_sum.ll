%struct = type { i64, i64 }
%arr = type [ 5 x %struct ]

@src = global %arr [ %struct { i64 1, i64 1 }, %struct { i64 2, i64 2 }, %struct { i64 3, i64 3 }, %struct { i64 4, i64 4 }, %struct { i64 5, i64 6 } ]
@tgt = global %arr [ %struct { i64 1, i64 1 }, %struct { i64 1, i64 1 }, %struct { i64 1, i64 1 }, %struct { i64 1, i64 1 }, %struct { i64 1, i64 1 } ]

define void @arrcpy (%arr* %s1, %arr* %s2) {
    %i = alloca i64
    store i64 0, i64* %i 
    br label %loops 
loops: 
    %i_val = load i64, i64* %i
    %1 = getelementptr %arr, %arr* %s1, i32 0, i64 %i_val, i32 0
    %2 = getelementptr %arr, %arr* %s1, i32 0, i64 %i_val, i32 1
    %3 = getelementptr %arr, %arr* %s2, i32 0, i64 %i_val, i32 0
    %4 = getelementptr %arr, %arr* %s2, i32 0, i64 %i_val, i32 1
    %char1 = load i64, i64* %1
    store i64 %char1, i64* %3
    %char2 = load i64, i64* %2
    store i64 %char2, i64* %4
    %newi = add i64 1, %i_val
    store i64 %newi, i64* %i
    %e = icmp eq i64 %newi, 5
    br i1 %e, label %return, label %loops 
return: 
    ret void
}

define i64 @sum (%arr* %s1) {
    %i = alloca i64
    %acc = alloca i64
    store i64 0, i64* %i 
    store i64 0, i64* %acc
    br label %loops 
loops:
    %i_val = load i64, i64* %i
    %1 = getelementptr %arr, %arr* %s1, i32 0, i64 %i_val, i32 1
    %2 = load i64, i64* %1
    %3 = load i64, i64* %acc
    %4 = add i64 %2, %3
    store i64 %4, i64* %acc
    %newi = add i64 1, %i_val
    store i64 %newi, i64* %i
    %e = icmp eq i64 %newi, 5
    br i1 %e, label %return, label %loops
return:
    %ans = load i64, i64* %acc
    ret i64 %ans
}

define i64 @main(i64 %argc, i8** %arcv) {
    call void @arrcpy(%arr* @src, %arr* @tgt)
    %1 = call i64 @sum(%arr* @tgt)
    ret i64 %1
}