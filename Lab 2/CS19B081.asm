; We are including io.mac because it simplfies the program!
%include "io.mac"

.DATA
	query		db		"Encrypt a string? (y/n): ", 0

.UDATA
	input		resb	21			; To store our input string
	response	resb	1			; To store the character response of the user

.CODE
	.STARTUP
	
begin_cycle:
	PutStr		query				; Print query message
	GetCh		[response]			; Get response from user on whether to continue
	cmp			byte[response], 'y'	; Check whether response was yes
	jne			end_cycle			; If no, terminate program
	GetStr		input, 21			; Read in input
	
	mov			EBX, input			; EBX will help us loop through the string characters
begin_encryption:
	mov			AL, byte[EBX]		; Obtaining current character
	cmp			AL, 0				; Compare character with string terminator
	je			end_encryption		; If it matches finish encryption process

	cmp			AL, '0'				; Check if character is below digit bounds
	jb			no_change			; If so, print directly
	cmp			AL, '9'				; Check if character is above digit bounds
	ja			no_change			; If so, print directly

	add			AL, 5				; Add 5, which is our Caesar cipher
	cmp			AL, '9'				; Check if the obtained number exceeds the greatest digit
	jbe			no_change			; If not proceed to obtain ASCII value of encrypted digit
	sub			AL, 10				; Otherwise subtract 10 to obtain the units digit of the number

no_change:
	PutCh		AL					; Print the encrypted digit
	inc			EBX					; Increment EBX to move forward by one 
	jmp			begin_encryption	; Go back to repeat process for next character

end_encryption:
	nwln							; Printing newline at the end of each output
	jmp			begin_cycle
end_cycle:
	
.EXIT
	
