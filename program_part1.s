	.global main
	.data
START1: .asciz "CAT"
START2: .asciz "BAT"
LEN: .word 0
LENGTH: .word 3
GREATER: .word 0xFFFFFFFF
	.text
main: 
	LDR R6,=START1 				@load the address of START1
	LDR R9,=START2 				@load the address of START2
	LDR R3,=LENGTH 				@load the address of Length
	LDR R4,=GREATER				@load the address of GREATER
	EOR R1,R1,R1 				@clear R1 to store string length
Loop:
	ADD R1,R1,#1 				@increment the count
	CMP R1, R3
	BGT bigger
	LDRB R7,[R6],#1 			@load the string1 first byte into R7
	LDRB R8,[R9],#1 			@load the string2 first byte into R8
	CMP R7, R8					@compare fetched bytes
	BEQ Loop					@if bytes are same, go for next byte comparison
	CMP R7, R8					@else check for big or small condition
	BGT bigger					@if string1 byte is big, go to bigger label and clear GREATER variable.
	B Done						@else if string1 byte is small, go to Done label and no need to update GREATER.
bigger:
	EOR R1,R1,R1 
	STR R1,[R4] 				@otherwise, store the result
Done:
	SWI 0x11
	.end