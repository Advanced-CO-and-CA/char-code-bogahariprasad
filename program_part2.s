/******************************************************************************
* file: program_part2.s
* author: Hariprasad Boga
* Guide: Prof. Madhumutyam IITM, PACE
* Guide: G S Nitesh Narayana
******************************************************************************/

/*
  This is the code for assignment 4
  */

  @ BSS section
      .bss

  @ DATA SECTION
	.data
STRING: .asciz "CS6620"
SUBSTR: .asciz "6"
PRESENT: .word 0

  @ TEXT section
	.text
.globl _main


_main: 
	LDR R6,=STRING 				@load the address of STRING
	LDR R9,=SUBSTR 				@load the address of SUBSTR
	EOR R1,R1,R1 				@clear R1 to start the index counting
REPEAT:
Loop:
	LDRB R7,[R6],#1 			@load the string1 first byte into R7
	LDRB R8,[R9],#1 			@load the string2 first byte into R8
	CMP R8,#0					@if substring character reaches the end then result found.
	BEQ FOUND
	CMP R7, R8					@compare fetched bytes
	BEQ Loop					@if bytes are same, go for next byte comparison
	LDR R6,=STRING 				@load the address of STRING
	LDR R9,=SUBSTR 				@load the address of SUBSTR
	ADD R1,R1,#1				@increment the STRING index
	ADD R6,R6,R1				@search for substring from next character
	LDRB R7,[R6]				@Check if source string is reached to the end.
	CMP R7, #0					@Compare with 0 to check for NULL character
	BNE REPEAT					@if character is not NULL, repeat the search process
	EOR R1,R1,R1
	B DONE						@else stop searching
FOUND:
	ADD R1,R1,#1				@increment the index to have result starting from 1.
	LDR R8,=PRESENT				@load the address of PRESENT
	STR R1,[R8]
DONE:
	SWI 0x11
	.end