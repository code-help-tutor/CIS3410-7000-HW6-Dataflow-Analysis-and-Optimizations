define i64 @is_odd(i64 %m) {
    %result = and i64 %m, 1
    ret i64 %result ; result = 1 iff m is odd
}

define i64 @collatz(i64 %n) {
    %num_iterations = alloca i64
    store i64 0, i64* %num_iterations
    %current_n = alloca i64 
    store i64 %n, i64* %current_n
    br label %rec
rec: 
    %n_val = load i64, i64* %current_n
    %is_one = icmp eq i64 %n_val, 1
    br i1 %is_one, label %return, label %continue
continue:
    %is_odd = call i64 @is_odd(i64 %n_val)
    %odd_cond = icmp eq i64 %is_odd, 1 
    br i1 %odd_cond, label %odd, label %even ; determine if current n is odd or even
even: 
    %iterations = load i64, i64* %num_iterations
    %new_num_iterations = add i64 %iterations, 1 ; increment number of iterations
    store i64 %new_num_iterations, i64* %num_iterations
    %n_val2 = load i64, i64* %current_n
    %new_n_val = ashr i64 %n_val2, 1
    store i64 %new_n_val, i64* %current_n
    br label %rec
odd: 
    %iterations2 = load i64, i64* %num_iterations
    %new_num_iterations2 = add i64 %iterations2, 1 ; increment number of iterations
    store i64 %new_num_iterations2, i64* %num_iterations
    %n_val3 = load i64, i64* %current_n
    %3 = mul i64 %n_val3, 3
    %new_n_val2 = add i64 %3, 1 
    store i64 %new_n_val2, i64* %current_n
    br label %rec
return: 
    %result = load i64, i64* %num_iterations
    ret i64 %result 
}

define i64 @main(i64 %argc, i8** %arcv) {
    %ans = call i64 @collatz(i64 7)
    ret i64 %ans
}