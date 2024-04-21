%arr = type [5 x i64]
@array = global %arr [i64 5, i64 4, i64 3, i64 2, i64 1]

define i64 @bubblesort_iteration(i64 %arraysize) {
  %latterindex = alloca i64
  store i64 1, i64* %latterindex
  %overmax = icmp slt i64 1, %arraysize
  br i1 %overmax, label %nextsort, label %endsort
nextsort:
  %liv2 = load i64, i64* %latterindex
  %formerindex = sub i64 %liv2, 1
  %ptr_first = getelementptr %arr, %arr* @array, i64 0, i64 %formerindex
  %ptr_second = getelementptr %arr, %arr* @array, i64 0, i64 %liv2
  %val_first = load i64, i64* %ptr_first
  %val_second = load i64, i64* %ptr_second
  %compare = icmp sle i64 %val_first, %val_second
  br i1 %compare, label %continue, label %swap
swap:
  store i64 %val_first, i64* %ptr_second
  store i64 %val_second, i64* %ptr_first
  br label %continue
continue:
  %liv3 = load i64, i64* %latterindex
  %newlatterindex = add i64 %liv3, 1
  store i64 %newlatterindex, i64* %latterindex
  %overmax2 = icmp slt i64 %newlatterindex, %arraysize
  br i1 %overmax2, label %nextsort, label %endsort
endsort:
  ret i64 0
}

define i64 @check_sorted(i64 %arraysize){
  %index = alloca i64
  store i64 1, i64* %index
  br label %condition
condition:
  %latterindex = load i64, i64* %index
  %overmax = icmp slt i64 %latterindex, %arraysize
  br i1 %overmax, label %loop, label %sorted
loop:
  %ptr_second = getelementptr %arr, %arr* @array, i64 0, i64 %latterindex
  %formerindex = sub i64 %latterindex, 1
  %ptr_first = getelementptr %arr, %arr* @array, i64 0, i64 %formerindex
  %val_first = load i64, i64* %ptr_first
  %val_second = load i64, i64* %ptr_second
  %compare = icmp sle i64 %val_first, %val_second
  br i1 %compare, label %continue, label %unsorted
continue:
  %newlatterindex = add i64 %latterindex, 1
  store i64 %newlatterindex, i64* %index
  br label %condition
sorted:
  ret i64 1
unsorted:
  ret i64 0
}

define i64 @main(i64 %argc, i8** %arcv) {
  br label %condition
condition:
  %is_sorted = call i64 @check_sorted(i64 5)
  %sorted_flag = icmp eq i64 %is_sorted, 1
  br i1 %sorted_flag, label %finished, label %sort
sort:
  %trash = call i64 @bubblesort_iteration(i64 5)
  br label %condition
finished:
  %check_first_element = getelementptr %arr, %arr* @array, i64 0, i64 0
  %first_element = load i64, i64* %check_first_element
  ret i64 %first_element
}