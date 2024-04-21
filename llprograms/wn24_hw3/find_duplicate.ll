%arr = type [6 x i64]
@array = global %arr [i64 483, i64 484, i64 445, i64 483, i64 482, i64 481]

define i64 @find_duplicate() {
  %i = alloca i64
  %j = alloca i64
  store i64 0, i64* %i
  br label %outer_loop

outer_loop:
  %i_val = load i64, i64* %i
  %cmp_i = icmp slt i64 %i_val, 5
  br i1 %cmp_i, label %inner_loop_init, label %no_duplicates

inner_loop_init:
  %j_val_i = add i64 %i_val, 1
  store i64 %j_val_i, i64* %j
  br label %inner_loop

inner_loop:
  %j_val = load i64, i64* %j
  %cmp_j = icmp slt i64 %j_val, 6
  br i1 %cmp_j, label %check_duplicate, label %increment_i

check_duplicate:
  %current_i = getelementptr %arr, %arr* @array, i64 0, i64 %i_val
  %current_j = getelementptr %arr, %arr* @array, i64 0, i64 %j_val
  %val_i = load i64, i64* %current_i
  %val_j = load i64, i64* %current_j
  %cmp_val = icmp eq i64 %val_i, %val_j
  br i1 %cmp_val, label %duplicates_found, label %increment_j

increment_i:
  %new_i_val = add i64 %i_val, 1
  store i64 %new_i_val, i64* %i
  br label %outer_loop

increment_j:
  %new_j_val = add i64 %j_val, 1
  store i64 %new_j_val, i64* %j
  br label %inner_loop

duplicates_found:
  ret i64 1

no_duplicates:
  ret i64 0
}

define i64 @main(i64 %argc, i8** %arcv) {
  %res = call i64 @find_duplicate()
  ret i64 %res
}
