define i64 @combination(i64 %n, i64 %r)
{
	%v1 = icmp eq i64 %r, 0
	%v2 = icmp eq i64 %r, %n
	br i1 %v1, label %rtn1, label %c1
c1:
	br i1 %v2, label %rtn1, label %c2
c2:
	%v3 = sub i64 %n, 1
	%v4 = sub i64 %r, 1
	%v5 = call i64 @combination(i64 %v3, i64 %v4)
	%v6 = call i64 @combination(i64 %v3, i64 %r)
	%v7 = add i64 %v5, %v6
	ret i64 %v7
rtn1:
	ret i64 1
}

define i64 @main(i64 %argc, i8** %argv) 
{
	%v1 = call i64 @combination(i64 9, i64 4)
	ret i64 %v1
}
