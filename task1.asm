.model small
.stack 200h
.data
msg1 db 10,13,"enter choice number : $"
msg2 db 10,13,"enter the value: $" 
msg3 db 10,13,"Answer: $"  
n dw ?    
deci db 4 dup(?)
n1 dw 4 dup(?)
n2 dw 4 dup(?)
.code
mov ax,@data
mov ds,ax

  
call services
hook:  
 
mov word ptr es:[0x65*4],isrror 
mov word ptr es:[0x65*4+2],cs

.exit 



services proc
   
     isrror:         

mov si,0
mov di,0
l4:
mov cx,4
mov si,0
mov bx,offset n1
mov ah,0x9
mov dx,offset msg2
int 0x21
l3:
mov ax,0h
mov ah,0x1h
int 0x21
sub ax,0x30
mov dx,0  
mov dl,al   
mov [bx+si],dx
add si,2 
loop l3 

mov cx,4
mov si,0
mov dx,0  
mov bx,offset n1
ls:   
or dx,[bx+si]
cmp cx,1
je ld
rol dx,4
ld:
add si,2 
loop ls

mov n2+di,dx

inc di  
inc di
cmp di,8
jne l4

mov si,0x2000
mov word ptr ds:[si],bx   

;1service
mov ah,0x9
mov dx,offset msg3
int 0x21

mov cx,4
mov si,0
l1:
mov dh,0
mov bx,offset n2
mov ax,[bx+si]
cmp ax,0000h
je z
cmp ax,0001h
je o
cmp ax,0010h
je t
cmp ax,0011h
je th
cmp ax,0100h
je fo
cmp ax,0101h
je fi
cmp ax,0110h
je s
cmp ax,0111h
je se
cmp ax,1000h
je ei
cmp ax,1001h
je ni
cmp ax,1010h
je A
cmp ax,1011h
je B
cmp ax,1100h
je C
cmp ax,1101h
je D
cmp ax,1110h
je E
cmp ax,1111h
je F

z:
mov ax, 0
jmp km
o:
mov ax,1
jmp km 
t:
mov ax,2
jmp km 
th:
mov ax,3
jmp km 
fo:
mov ax,4
jmp km 
fi:
mov ax,5
jmp km 
s:
mov ax,6
jmp km
se:
mov ax,7
jmp km 
ei:
mov ax,8
jmp km 
ni:
mov ax,9
jmp km 
A:
mov ax,10
jmp km
B:
mov ax,11
jmp km
C:
mov ax,12
jmp km
D:
mov ax,13
jmp km
E:
mov ax,14
jmp km
F:
mov ax,15
jmp km
km:
cmp ax,9
  jle la   
  add ax,37h
  jmp ka
  la:
  add ax,30h
  ka: 
en:
mov deci+si,al
push ax
 mov ah,0x2
pop dx
int 21h


add si,2

loop l1


mov cx,4
jmp hook
 iret 
services endp