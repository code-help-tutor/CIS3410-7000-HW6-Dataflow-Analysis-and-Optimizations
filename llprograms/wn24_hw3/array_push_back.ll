%ArrayStruct = type { i64*, i64 }

define void @push_back(%ArrayStruct* %arrayStruct, i64 %value) {
  %sizePtr = getelementptr %ArrayStruct, %ArrayStruct* %arrayStruct, i32 0, i32 1
  %size = load i64, i64* %sizePtr
  %arrayPtr = getelementptr %ArrayStruct, %ArrayStruct* %arrayStruct, i32 0, i32 0
  %array = load i64*, i64** %arrayPtr
  %addr = getelementptr i64, i64* %array, i64 %size
  store i64 %value, i64* %addr
  %newSize = add i64 %size, 1
  store i64 %newSize, i64* %sizePtr
  ret void
}

define i64 @main(i64 %argc, i8** %arcv) {
  %array = alloca [10 x i64]
  %arrayptr = bitcast [10 x i64]* %array to i64*
  %arrayStruct = alloca %ArrayStruct
  %sizePtr = getelementptr %ArrayStruct, %ArrayStruct* %arrayStruct, i32 0, i32 1
  store i64 0, i64* %sizePtr
  %arrayPtrSlot = getelementptr %ArrayStruct, %ArrayStruct* %arrayStruct, i32 0, i32 0
  store i64* %arrayptr, i64** %arrayPtrSlot
  call void @push_back(%ArrayStruct* %arrayStruct, i64 42)
  call void @push_back(%ArrayStruct* %arrayStruct, i64 66)
  %finalSize = load i64, i64* %sizePtr
  %lastIndex = sub i64 %finalSize, 1
  %finalArrayPtr = getelementptr i64, i64* %arrayptr, i64 %lastIndex
  %lastValue = load i64, i64* %finalArrayPtr
  ret i64 %lastValue
}