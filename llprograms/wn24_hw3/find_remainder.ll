define i64 @remainder(i64 %num, i64 %divisor) {
entry:
  ; Check if divisor is 0
  %isDivisorZero = icmp eq i64 %divisor, 0
  br i1 %isDivisorZero, label %exit, label %nonZeroDivisor

nonZeroDivisor:
  ; Initialize remainder
  *%remainder = alloca i64
  store i64 %num, i64* *%remainder

  ; Loop to calculate remainder
  br label %start

start:
  %currRemainder = load i64, i64* *%remainder
  %isGreaterOrEqual = icmp sge i64 %currRemainder, %divisor
  br i1 %isGreaterOrEqual, label %updateRemainder, label %exit

updateRemainder:
  %updatedRemainder = sub i64 %currRemainder, %divisor
  store i64 %updatedRemainder, i64* *%remainder
  br label %start

exit:
  ; Return the final remainder
  ret i64 *%remainder
}

; Entry point
define i64 @main() {
  %result = call i64 @remainder(i64 5, i64 3)
  ret i64 %result
}