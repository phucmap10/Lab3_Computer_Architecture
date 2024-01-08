.data
	e: .float 2.71828
	#stuID = 2252639
	a: .float 2.0
	b: .float 2.0
	c: .float 5.0
	d: .float 2.0
	u: .float 6.0
	v: .float 3.0
	result: .asciiz "Result: "
	bon: .float 4.0
	
.text
main:
	#f(u) - f(v) u = 6, v = 3
	l.s $f1, u #f1 = 6
	l.s $f2, a #f2 = 2
	l.s $f3, c #f3 = 5
	l.s $f4, v #f4 = 3
	mul.s $f9, $f1, $f1
	mul.s $f9, $f9, $f1
	mul.s $f9, $f9, $f1
	mul.s $f9, $f9, $f1
	mul.s $f9, $f9, $f2
	div.s $f9, $f9, $f3 # 2/5*6^5
	
	mul.s $f8, $f1, $f1
	mul.s $f8, $f8, $f1
	mul.s $f8, $f8, $f1
	div.s $f8, $f8, $f2 #chia 2 1 lan do b/4, b = 2 => 1/2*x^4
	
	
	mul.s $f7, $f1, $f1
	mul.s $f7, $f7, $f1
	mul.s $f7, $f7, $f3
	div.s $f7, $f7, $f4 #c=5 c/3 x^3
	
	l.s $f6, u
	add.s $f9, $f9, $f8
	add.s $f9, $f9, $f7
	add.s $f9, $f9, $f6 #f9 dang luu gia tri cua f(u)
	
	mul.s $f15, $f4, $f4
	mul.s $f15, $f15, $f4
	mul.s $f15, $f15, $f4
	mul.s $f15, $f15, $f4
	mul.s $f15, $f15, $f2
	div.s $f15, $f15, $f3 # 2/5*3^5
	
	mul.s $f16, $f4, $f4
	mul.s $f16, $f16, $f4
	mul.s $f16, $f16, $f4
	div.s $f16, $f16, $f2 #chia 2 1 lan do b/4, b = 2 => 1/2*x^4
	
	mul.s $f17, $f4, $f4
	mul.s $f17, $f17, $f4
	mul.s $f17, $f17, $f3
	div.s $f17, $f17, $f4 #c=5 c/3 x^3
	
	l.s $f18, v #d = 2 nen d/2 = 1 => f18 giu gia tri cua x(v)
	add.s $f15, $f15, $f16
	add.s $f15, $f15, $f17
	add.s $f15, $f15, $f18 #f15 luu gia tri cua f(v)
	sub.s $f9, $f9, $f15
	l.s $f1, e
	div.s $f9, $f9, $f1
	div.s $f9, $f9, $f1
	
	li $v0, 2
	mov.s $f12, $f9
	syscall
	
	li $v0, 10
	syscall