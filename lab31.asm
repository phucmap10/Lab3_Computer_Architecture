.data
	Choose1: .asciiz "Calculate volume or total surface area? 1. Volume 2.Total surface area"
	Choose2: .asciiz" Choose shape: 1.rectangular box, 2.cube, 3.cylinder, 4.pyramid, 5.prism, or 6.sphere."
	param_prompt: .asciiz "Enter the parameter (length, width, height, radius, etc.): "
	result_msg: .asciiz "Result: "
	shape_prism: .asciiz "Choose shape: 1.Triangular, 2. Rectangular, 3.Square, 4.Pentagonal, 5.Hexagonal"
	square_para_prism: .asciiz "Base edge and length: "
	pen_para_prism: .asciiz "Apothem, height and base edge?: "
	pyramid_para: .asciiz "Base edge, and height:  "
	nam: .float 5
	 pi: .float 3.14159
	 hai: .float 2.0
	 ba: .float 3.0
.text
main:
	li $v0, 4
	la $a0, Choose1
	syscall
	
	li $v0, 5
    	syscall
   	move $t0, $v0 
   	
   	li $v0, 4
   	la $a0, Choose2
   	syscall
   	
   	li $v0, 5
   	syscall
   	move $t1, $v0
   	
   	beq $t0, 1, volume_cal
   	beq $t0, 2, area_cal
   	
volume_cal:
	beq $t1, 1, box_vol
   	beq $t1, 2, cube_vol
   	beq $t1, 3, cyclinder_vol
   	beq $t1, 4, pyramid_vol
   	beq $t1, 5, prism_vol
   	beq $t1, 6, sphere_vol
   	
area_cal:
	beq $t1, 1, box_area
   	beq $t1, 2, cube_area
   	beq $t1, 3, cyclinder_area
   	beq $t1, 4, pyramid_area
   	beq $t1, 5, prism_area
   	beq $t1, 6, sphere_area
   	
box_vol:
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # length
	li $v0, 6
	syscall
	mov.s $f11, $f0 # width
	li $v0, 6
	syscall
	mov.s $f12, $f0 # height
	mul.s $f10, $f10, $f11
	mul.s $f10, $f10, $f12
	
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f10
	syscall
	j sysend

cube_vol:
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # length
	mov.s $f11, $f0
	mul.s $f10, $f10, $f10
	mul.s $f10, $f10, $f11
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f10
	syscall
	j sysend
	
cyclinder_vol:
	l.s $f1, pi
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # radius
	li $v0, 6
	syscall
	mov.s $f11, $f0 # height
	mul.s $f10, $f10, $f10
	mul.s $f10, $f10, $f1
	mul.s $f10, $f10, $f11
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f10
	syscall
	j sysend
	
	
pyramid_vol:
	l.s $f1, ba
	l.s $f2, hai
	la $a0 , pyramid_para
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 #base edge
	li $v0, 6
	syscall
	mov.s $f11, $f0 # height
	
	mul.s $f3, $f10, $f10 # Square pyramid
	mul.s $f3, $f3, $f11
	div.s $f3, $f3, $f1
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
prism_vol:
	li $v0, 4
	la $a0, shape_prism
	syscall 
	li $v0, 5
	syscall
	move $t1, $v0
	beq $t1, 1, Tri_prism
	beq $t1, 2, Rec_prism
	beq $t1, 3, Square_prism
	beq $t1, 4, Pen_prism
	beq $t1, 5, Hex_prism

sphere_vol:
	l.s $f1, ba
	l.s $f2, hai
	l.s $f4, pi
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # radius
	mul.s $f3, $f10, $f10
	mul.s $f3, $f3, $f10
	mul.s $f3, $f3, $f4
	mul.s $f3, $f3, $f2
	mul.s $f3, $f3, $f2
	div.s $f3, $f3, $f1
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
	
box_area:
	l.s $f2, hai
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # length
	li $v0, 6
	syscall
	mov.s $f11, $f0 # height
	li $v0, 6
	syscall
	mov.s $f9, $f0 # width
	
	mul.s $f3, $f10, $f9
	mul.s $f3, $f3, $f2
	
	mul.s $f4, $f10, $f11
	mul.s $f4, $f4, $f2
	
	mul.s $f5, $f9, $f11
	mul.s $f5, $f5, $f2
	
	add.s $f3, $f3, $f4
	add.s $f3, $f3, $f5
	
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
cube_area:
	l.s $f2, hai
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # length
	
	mul.s $f3, $f10, $f10
	mul.s $f3, $f3, $f2
	mul.s $f3, $f3, $f2
	
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
cyclinder_area:
	l.s $f2, hai
	l.s $f1, pi
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # radius
	li $v0, 6
	syscall
	mov.s $f11, $f0 # height
	mul.s $f12, $f10, $f2
	mul.s $f12, $f12, $f11
	mul.s $f12, $f12, $f1
	
	mul.s $f13, $f10, $f10
	mul.s $f13, $f13, $f2
	mul.s $f13, $f13, $f1
	add.s $f12, $f12, $f13
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	syscall
	j sysend
	
pyramid_area: #square pyramid
	l.s $f2, hai
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # edge length
	li $v0, 6
	syscall
	mov.s $f11, $f0 # s
	
	mul.s $f3, $f2, $f10
	mul.s $f3, $f3, $f11
	
	mul.s $f4, $f10, $f10
	add.s $f3, $f3, $f4
	
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
prism_area:
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # s1
	li $v0, 6
	syscall
	mov.s $f11, $f0 # s2 = b
	li $v0, 6
	syscall
	mov.s $f9, $f0 # s3
	li $v0, 6
	syscall
	mov.s $f8, $f0 # height
	li $v0, 6
	syscall
	mov.s $f7, $f0 # length
	
	mul.s $f3, $f11, $f8
	add.s $f4, $f10, $f11
	add.s $f4, $f4, $f9
	mul.s $f4, $f4, $f7
	
	add.s $f3, $f3, $f4
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
	
sphere_area:
	l.s $f2, hai
	l.s $f1, pi
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # radius
	
	mul.s $f3, $f10, $f10
	mul.s $f3, $f3, $f1
	mul.s $f3, $f3, $f2
	mul.s $f3, $f3, $f2
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend

Tri_prism:
	l.s $f2, hai
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # base edge
	li $v0, 6
	syscall
	mov.s $f9, $f0 # height
	li $v0, 6
	syscall
	mov.s $f8, $f0 # length
	
	mul.s $f3, $f10, $f9
	mul.s $f3, $f3, $f8
	div.s $f3, $f3, $f2
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
	
Rec_prism:
	li $v0, 4
	la $a0 , param_prompt
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # width
	li $v0, 6
	syscall
	mov.s $f9, $f0 # height
	li $v0, 6
	syscall
	mov.s $f8, $f0 # length
	
	mul.s $f3, $f8, $f9
	mul.s $f3, $f3, $f10
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
	
Square_prism:
	li $v0, 4
	la $a0 , square_para_prism
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # base edge
	li $v0, 6
	syscall
	mov.s $f9, $f0 #length
	mul.s $f3, $f10, $f10
	mul.s $f3, $f3, $f9
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
Pen_prism:
	l.s $f2, hai
	l.s $f5, nam
	li $v0, 4
	la $a0 , pen_para_prism
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # apothem
	li $v0, 6
	syscall
	mov.s $f9, $f0 #base edge
	li $v0, 6
	syscall
	mov.s $f8, $f0 #height
	
	mul.s $f3, $f9, $f10
	mul.s $f3, $f3, $f8
	mul.s $f3, $f3, $f5
	div.s $f3, $f3, $f2
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
Hex_prism:
	l.s $f2, ba
	li $v0, 4
	la $a0 , pen_para_prism
	syscall
	li $v0, 6
	syscall
	mov.s $f10, $f0 # apothem
	li $v0, 6
	syscall
	mov.s $f9, $f0 #base edge
	li $v0, 6
	syscall
	mov.s $f8, $f0 #height
	
	mul.s $f3, $f9, $f10
	mul.s $f3, $f3, $f8
	mul.s $f3, $f3, $f2
	li $v0, 4
	la $a0, result_msg
	syscall
	li $v0, 2
	mov.s $f12, $f3
	syscall
	j sysend
	
sysend:
	li $v0, 10
	syscall
