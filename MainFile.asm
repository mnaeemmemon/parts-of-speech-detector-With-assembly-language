TITLE My First Program (coslProject.asm)
INCLUDE Irvine32.inc
.data

filehandle DWORD ?

filename BYTE "InputFile.txt", 0
Verb BYTE "Verb.txt", 0
Pronoun BYTE "Pronoun.txt", 0
Adverb BYTE "Adverb.txt", 0
Adjective BYTE "Adjective.txt", 0
Conjunction BYTE "Conjunction.txt", 0
Interjection BYTE "Interjection.txt", 0
Preposition BYTE "Preposition.txt", 0

N BYTE "(Noun) ", 0
V BYTE "(Verb) ", 0
P BYTE "(Pronoun) ", 0
Ad BYTE "(Adverb) ", 0
Aj BYTE "(Adjective) ", 0
Con BYTE "(Conjunction) ", 0
Ij BYTE "(Interjection) ", 0
Pp BYTE "(Preposition) ", 0

array byte 10000 DUP(?)
array1 byte 10000 DUP(?)
array2 byte 10000 DUP(?)
array3 byte 10000 DUP(?)
array4 byte 10000 DUP(?)
array5 byte 10000 DUP(?)
array6 byte 10000 DUP(?)
array7 byte 10000 DUP(?)

tempArray byte 20 DUP (0)
BuffSize dword 10000
temp dword 0h
temp2 dword 0h
temp3 dword ?
temp4 dword 0
t dword 0

.code
main proc	
	
	;Taking Input From File (Start)

	mov  edx,OFFSET filename
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Verb
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array1
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Pronoun
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array2
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Adjective
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array3
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Adverb
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array4
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Conjunction
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array5
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Preposition
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array6
	mov ecx,10000
	call ReadFromFile

	mov  edx,OFFSET Interjection
	call OpenInputFile
	mov  filehandle, EAX

	mov edx,offset array7
	mov ecx,10000
	call ReadFromFile

	;Taking Input From File (End)

	;Print (Start)
	
	mov ecx, BuffSize                   ;Number of characters to display
    mov esi, 0                    ;using indexing for characters
	mov ebx, 0
    L1:
        mov al, array[esi]
		cmp al, 0
		je Sw
        call WriteChar				; diplaying char by char 
        inc esi
    loop L1
	;Print (End)
	Sw:
	; to lowercase
	mov esi, 0
	mov ecx, sizeof array
	mov eax, 0

	Lo:
	
	mov al, array[esi]
	cmp al, 32
	je H
	
	cmp al, 64
	jg Se
	jmp En
	Se:
	cmp al, 123
	jl Se2
	jmp EN
	Se2:
	cmp al, 96
	jl I
	
	H:
	inc esi
	loop Lo

	jmp En

	I:
	add al, 32
	mov array[esi],al
	inc esi 
	loop Lo

	En:
	
	; to lowercase

	;Breaking(Start)
	call Crlf
	mov ecx, BuffSize 
	mov esi, 0
	mov edi, 0
	mov edx, 0
	mov eax, 0

	B:
	cmp array[esi],0
	je E
	cmp array[esi], 32
	je G
	mov al, array[esi]
	mov tempArray[edi], al
	inc esi
	inc edi
	loop B
	jmp E

	;Breaking(End)

	G:
	mov al, array[esi]
	mov tempArray[edi], al
	mov temp2, ecx

	mov temp, esi

	call Crlf
	mov edx, OFFSET tempArray
	call WriteString

	call checking

	mov esi, temp
	mov edi, 0
	mov ebx, temp2
	mov ecx,20
	C1:
	mov tempArray[edi],0
	inc edi
	loop C1

	mov ecx, ebx
	mov edi,0
	inc esi

	loop B

	E:
	call Crlf
exit
main endp

checking PROC

call Verbchecking
cmp temp3, 5h
je G
call Pronounchecking
cmp temp3, 5h
je G
call Adjectivechecking
cmp temp3, 5h
je G
call Adverbchecking
cmp temp3, 5h
je G
call Conjunctionchecking
cmp temp3, 5h
je G
call Prepositionchecking
cmp temp3, 5h
je G
call Interjectionchecking
cmp temp3, 5h
je G

mov edx, OFFSET N
call WriteString

G:
mov temp3, 0
ret
checking ENDP

Verbchecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array1[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array1[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array1[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array1[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET V
call WriteString
mov temp3, 5
s:
ret
Verbchecking ENDP

Pronounchecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array2[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array2[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array2[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array2[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET P
call WriteString
mov temp3, 5
s:
ret
Pronounchecking ENDP

Adjectivechecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array3[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array3[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array3[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array3[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET Aj
call WriteString
mov temp3, 5
s:
ret
Adjectivechecking ENDP

Adverbchecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array4[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array4[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array4[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array4[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET Ad
call WriteString
mov temp3, 5
s:
ret
Adverbchecking ENDP


Conjunctionchecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array5[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array5[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array5[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array5[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET Con
call WriteString
mov temp3, 5
s:
ret
Conjunctionchecking ENDP

Prepositionchecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0	
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array6[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array6[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array6[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array6[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET Pp
call WriteString
mov temp3, 5
s:
ret
Prepositionchecking ENDP

Interjectionchecking PROC

	mov eax, 0
	mov esi, 0
	mov edi,0
	mov ecx, buffSize

	L:
	cmp ecx, 0
	jle e1
	mov al, tempArray[edi]
	cmp array7[esi], 10
	je E
	inc esi
	loop L
	jmp e1

	E:
	cmp array7[esi+1], al
	je J
	add esi,1
	loop L
	
	J:
	add esi, 1
	mov t, esi
	mov ebx, ecx
	mov ecx, sizeof tempArray

	L2:
	mov al, tempArray[edi]
	cmp array7[esi], al
	je G
	jmp H
	G:
	cmp al, 65
	jl e2
	inc esi
	inc edi
	loop L2

	H:
	mov edi, 0
	mov ecx, ebx
	mov esi,t
	loop L
	
	e2:
	cmp array7[esi], 65
	jl e1
	jmp H

e1:
cmp ecx, 0
jg ru
jmp s
ru:
mov edx, OFFSET Ij
call WriteString
mov temp3, 5
s:
ret
Interjectionchecking ENDP
end main