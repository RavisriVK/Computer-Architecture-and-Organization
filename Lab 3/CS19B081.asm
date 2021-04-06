%include "io.mac"

.DATA
	terminate_msg	db	"Terminate? (Y/y) ", 0

.UDATA
	array		resd	100		; Reserve memory for 100 4-byte elements
	response	resb	1		; Holds response of user on whether to terminate or not

.CODE
	.STARTUP
	
query:
	GetLInt	ECX					; Obtain number of elements (n)
	mov		EAX, 0				; Set low=0
	mov		EBX, ECX			; Set high=n
	
	mov		ESI, 0				; Iterate from 0 to n and read in array

get_elements:					
	GetLInt	[array+ESI*4]		; Obtain element at index ESI
	inc		ESI					; Increment index
	loop	get_elements		;
	
	GetLInt	ECX					; Obtain key value and hold in ECX

; This version of binary search uses a singe comparison in each stage
; In every stage, key can only be in [low, high)
binary_search:
	dec		EBX					; EBX-high, EAX-low
	cmp		EBX, EAX			; Check high-1>low
	jbe		check				; If there is only one element, exit binary search
	inc		EBX					; Reobtain high in EBX
	
	mov		ESI, EAX			; ESI holds low
	add		ESI, EBX			; ESI is now sum of low and high
	sar		ESI, 1				; Divide by 2 to obtain average of low and high- ESI holds middle
	
	cmp		ECX, [array+4*ESI]	; Check if key is less than the middle element
	jae		right_half			; If not, key is in right half
	mov		EBX, ESI			; If key is in left half, update high
	jmp		binary_search
right_half:
	mov		EAX, ESI			; If key is in right half, update low
	jmp		binary_search

; Once we have narrowed down our search to a single element, we can just compare that with the key
check:
	mov		ESI, EAX			; Hold low (the index of singled out element) in ESI
	cmp		[array+4*ESI], ECX	; Compare key and this element
	jne		not_found			; Check if they are equal
	PutCh	'1'					; If found, print 1
	jmp		proceed				; Go to check termination condition
not_found:	
	PutCh	'0'					; If not found, print 0
	
proceed:
	nwln						; Print a newline
	PutStr	terminate_msg
	GetCh	[response]
	
	cmp		byte[response], 'y'	; If response is Y/y, terminate program
	je		done
	cmp		byte[response], 'Y'
	je		done
	jmp		query
done:
.EXIT