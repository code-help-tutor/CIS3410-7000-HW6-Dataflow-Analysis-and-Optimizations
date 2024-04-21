define i64 @doAddition(i64 %a, i64 %b) {
  %1 = add i64 %a, %b
  ret i64 %1
}

define i64 @doThing(i64(i64, i64)* %fn) {
    %1 = call i64 %fn(i64 5, i64 7)
    ret i64 %1
}

define i64 @main(i64 %argc, i8** %arcv) {
  %1 = call i64 @doThing(i64(i64, i64)* @doAddition)
  ret i64 %1
}