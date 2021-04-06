; We are including io.mac because it simplfies the program!
%include "io.mac"

; Note the there is no .DATA or .UDATA section- it was easier to simply use registers

.CODE
	.STARTUP

	; ECX is the number of inputs to be read- input count
	; EBX holds the sum of the inputs
	; EAX is used to hold the current input

	GetLInt	ECX				; Reading input count
	mov		EBX,		0	; initializing sum

sum_numbers:
	GetLInt	EAX				; Reading in number
	add		EBX,		EAX	; Adding to sum
	loop	sum_numbers		; Looping through the input count
	
	PutLInt	EBX				; Printing the sum of the numbers
	nwln					; Printing newline
	
.EXIT
	
