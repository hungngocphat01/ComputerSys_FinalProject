; DO AN CUOI KY MON HE THONG MAY TINH
; HOC KY 2 NAM HOC 2020 - 2021       
; GIANG VIEN: THAI HUNG VAN

; NGAY BAT DAU THUC HIEN: 04/05/2021 
; NGAY HOAN THANH: 06/05/2021    

; SINH VIEN THUC HIEN: HUNG NGOC PHAT (19120615)
; TRINH HOP DICH: EMU8086 

; LUU Y: LUON LUON XOA MAN HINH (CLS) TRUOC KHI CHAY TRONG DOSBOX DE TRANH PHAT SINH LOI HIEN THI                

data segment
    msg1 db "Trang thai numlock: $"
    msg2 db "Trang thai capslock: $"
    msg3 db 10, 13, "Nhap 2 so sau de ve mot hinh chu nhat MxN:", 10, 13, 24h
    msg4 db 10, 13, "Hay nhap 2 so tu nhien: ", 10, 13, 24h 
    msg_none db 10, 13, "Khong co den nao sang. Khong co chuc nang nao duoc thuc hien.$"
    msg_dh db 10, 13, "Bay gio la $"
    msg_dt db 10, 13, "Hom nay la $"
    msg_ctrl db 10, 13, "Nhan giu CTRL de thoat.", 10, 13, "Hay xoa man hinh (cls) truoc khi chay de tranh phat sinh loi.", 10, 10, 13, 24h
    msg_tong db 10, 13, "M + N = $"
    msg_hieu db 10, 13, "M - N = $"
    msg_tich db 10, 13, "M * N = $"
    msg_thuong db 10, 13, "M / N = $"
    msg_n db 10, 13, "Hay nhap N <= 9 (khong ENTER): $"
    msg_m db 10, 10, 13, "Hay nhap M <= 9 (khong ENTER): $"
    wsunday db "Chu nhat$"
    wworkday db "Thu $"
    wsep db ", $"
    wspa db "     $"
    newline db 10, 13, 24h
    m db 0
    n db 0 
    
    x db 0, 0
    y db 0, 0               
ends  

stack segment
    st db dup(100)
ends
                  
                  
                  
                  
                  
code segment      
; Thu tuc de in so nguyen co 2 chu so trong thanh ghi al
; cl = 1 de buoc hien thi 2 chu so
printNumberAL proc                                      
    push ax
    push cx
    push dx
    ; Neu la so nguyen co 2 chu so
    cmp al, 10                    
    jge prntNumber_2chuso
    
    ; Neu cl = 1 thi hien thi them so 0
    cmp cl, 1
    jne prntNumber_1chuso
    
    mov ah, 2
    mov dl, '0'  
    push ax
    int 21h
                                  
    pop ax  
prntNumber_1chuso:   
    ; Neu la so nguyen co 1 chu so
    add al, 30h ; ascii cua so 0
    mov ah, 2
    mov dl, al
    int 21h
    jmp prntNumber_end
prntNumber_2chuso:
    mov dx, 0
    mov ah, 0 ; ax = al
    mov bx, 10
    div bx    ; al = ax/bx = ax/10 = chu so thu nhat -> cl
              ; dl = phan du = chu so thu 2 -> ch
    mov cl, al
    mov ch, dl
    mov ah, 2
    ; In 2 chu so ra man hinh
    mov dl, cl
    add dl, 30h
    int 21h
    
    mov dl, ch
    add dl, 30h
    int 21h
prntNumber_end:
    pop dx
    pop cx
    pop ax
    ret
endp         

    
; In 1 chuoi ki tu tu dx    
printDX proc
    push ax
    mov ah, 9h
    int 21h
    pop ax
    ret    
endp

printRect proc
    lea dx, msg3
    call printDX
    
    lea dx, msg_m          ; Nhap m (so hang) 
    call printDX           
    
    mov ah, 0ch            ; Flush buffer
    mov al, 1              ; Doc 1 ki tu vao al
    int 21h
    mov m, al
    sub m, 30h
    
    lea dx, msg_n          ; Nhap n (so cot)
    call printDX                   
    
    mov ah, 0ch
    mov al, 1              
    int 21h
    mov n, al
    sub n, 30h
    
    mov cl, n              ; cl = original n 
    
    ; Chay 2 vong lap
    ; Vong lap ngoai de chay theo so cot, vong lap ngoai chay theo so hang
row_loop:
    cmp m, 0               ; while (m > 0) {                 
    je printRect_end
    lea dx, newline        ;  print \r\n
    call printDX
    mov n, cl              ;  n = N (cl)
    dec m                  ;  m--
col_loop:                  ;  do {
    mov ah, 2                      
    mov dl, '*'            ;   print '*'
    int 21h 
    dec n                  ;   n--
    cmp n, 0               ;  } while (n > 0)
    je row_loop            ; }
    jmp col_loop
    
printRect_end:        
    ret    
endp
      
      
      
      
      
      
calculate2Num proc
    lea dx, msg4
    call printDX
    
    lea dx, msg_m          ; Nhap m
    call printDX           
    
    mov ah, 0ch            ; Flush buffer
    mov al, 1              ; Doc 1 ki tu vao al
    int 21h
    mov m, al
    sub m, 30h
    
    lea dx, msg_n          ; Nhap n
    call printDX                   
    
    mov ah, 0ch
    mov al, 1              
    int 21h
    mov n, al
    sub n, 30h 
    
    
    lea dx, msg_tong       ; Tinh tong    
    call printDX
    
    mov ax, 0
    mov al, m
    add al, n              ; al = m + n
    
    call printNumberAL               
    
    lea dx, msg_hieu       ; Tinh hieu    
    call printDX
    
    mov ax, 0
    mov al, m
    mov ah, n
    cmp al, ah              ; Neu m < n thi tinh tri tuyet doi roi them - vao truoc
    jb abs
    
    sub al, ah
    jmp calc_printMinus

abs:    
    sub ah, al             ; ah = n - m
    mov al, ah
    
    push ax
    push dx
    
    mov ah, 2
    mov dl, '-'
    int 21h
    
    pop dx
    pop ax
        
calc_printMinus:
    call printNumberAL
    
    lea dx, msg_thuong     ; Tinh thuong
    call printDX                
        
    mov al, m              ; ax = m
    mov ah, 0
    mov bl, n
    
    div bl                 ; al = ax/bx = m/n
                           ; ah = so du
                        
                           ; In ra ket qua o dang: phannguyen + sodu/sochia = q + r/n
    call printNumberAL     ; in ra phan nguyen
        
    
    cmp ah, 0              ; Neu du 0 thi khong can in phan du
    je calc_printMul
    push ax
    
    mov ah, 2
    mov dl, '+'            ; in ra dau +
    int 21h
    
    pop ax                 ; in ra so du
    mov al, ah
    call printNumberAL
    
    mov ah, 2
    mov dl, '/' 
    int 21h                ; in ra dau /
    
    mov al, n              ; in ra so chia
    call printNumberAL                       
calc_printMul:
    lea dx, msg_tich       ; In ra tich
    call printDX
    
    mov ax, 0
    mov al, m
    mov bl, n
    mul bl                 ; al = ax = m*n
              
    call printNumberAL     
    ret
endp



              

showClock proc
    lea dx, msg_ctrl       ; print Nhan CTRL
    call printDX 
                  
    
    lea dx, msg_dt         ; print Hom nay la 
    call printDX 
                                             
    mov bh, 0              ; Lay vi tri hien tai cua con tro
    mov ah, 3h             ; dl = x, dh = y
    int 10h                                                 
    
    mov byte ptr x[0], dl  ; x[0], y[0] la vi tri can hien thi ngay
    mov byte ptr y[0], dh                                          
    
    lea dx, msg_dh         ; print Bay gio la
    call printDX                            
    
    mov bh, 0
    mov ah, 03h
    int 10h
    
    mov byte ptr x[1], dl  ; x[1], y[1] la vi tri can hien thi gio
    mov byte ptr y[1], dh   
        
clock_loop:
    mov ah, 2ah
    int 21h                ; Lay ngay he thong
    
    ; CX = year (1980-2099). DH = month. DL = day. AL = day of week (00h=Sunday)
    
    push cx
    push dx
    mov ah, 2              ; Di chuyen con tro toi vi tri in ngay
    mov dh, y[0]
    mov dl, x[0]
    mov bh, 0
    int 10h
    
    cmp al, 0              ; In ngay
    jne clock_MonFri
    lea dx, wsunday        ; al = 0 -> chu nhat
    call printDX
    
clock_MonFri:   
    lea dx, wworkday
    call printDX     
    inc al                 ; 1 = thu 2, 2 = thu 3, ...
    call printNumberAL
    
clock_prntMonth:      
    lea dx, wsep
    call printDX
                      
    pop dx                  ; In ngay trong thang (1, 2, ..., 31) 
    mov cl, 1
    mov ah, 2
    mov al, dl            
    call printNumberAL  
    
    mov dl, '/'
    int 21h
    
    mov cl, 1
    mov al, dh              ; In thang
    call printNumberAL                        
                                           
    mov dl, '/'
    int 21h
    
    pop cx
    cmp cx, 2000
    jb clock_yrLess2000
    ; Neu nam >= 2000
    
    sub cx, 2000             ; cx = cl = 2 so cuoi cua nam
    
    push cx
    mov al, 20
    call printNumberAL  
    
    jmp clock_show2DigitYr

; Neu nam < 2000    
clock_yrLess2000:
    sub cx, 1900             ; cx = cl = 2 so cuoi cua nam
    mov al, 19          
    call printNumberAL 
    
clock_show2DigitYr:
    pop cx
    mov al, cl
    call printNumberAL
    
    lea dx, wspa             ; In them vai khoang trang de tranh khong hien lai ngay cu
    call printDX
                      
                      
    mov ah, 2                ; Di chuyen con tro toi vi tri in gio
    mov dh, y[1]
    mov dl, x[1]
    mov bh, 0
    int 10h                   
    
    mov ah, 2ch              ; Lay gio he thong
    int 21h
    push dx
    push cx
    
    mov al, ch               ; In gio
    mov cl, 1
    call printNumberAL
    
    mov ah, 2
    mov dl, ':'
    int 21h
    
    pop cx
    mov al, cl               ; In phut
    mov cl, 1
    call printNumberAL
    
    mov ah, 2
    mov dl, ':'
    int 21h
    
    pop dx
    mov cl, 1
    mov al, dh               ; In giay
    call printNumberAL                
    
    lea dx, wspa
    call printDX             ; In them vai khoang trang de tranh khong hien lai gio cu
    
    
    mov cx, 0fh              ; Sleep 1s
    mov dx, 4240h
    mov ah, 86h
    int 15h                  
    
    mov ax, 40h              ; BIOS DATA AREA, Keyboard byte 0
    mov es, ax                        
    mov ax, es:[17h]         
    mov cl, 3                ; Bit 3: CTRL
    shr ax, cl
    jc clock_exit            ; Neu co nhan CTRL thi thoat             
                             
    jmp clock_loop
    
clock_exit:    
    ret
endp  


                                                      
main proc
    mov ax, @data          ; load data segment
    mov ds, ax 
     
    mov ax, 40h            ; doc tu bios data area
    mov es, ax     
    mov ax, es:[17h]
    mov bx, 0              
    
    mov cl, 2              ; kiem tra capslock co bat khong 
    shl al, cl       
    jnc test_numlock 

    mov bh, 1              ; bh = 1 <=> capslock co bat
    
test_numlock:    
    shl al, 1              ; kiem tra numlock
    jnc end_set   
    
    mov bl, 1              ; bl = 1 <=> numlock co bat 
  
end_set:          
    lea dx, msg1            ; print Trang thai numlock:
    call printDX
    
    mov al, bl              ; print state
    call printNumberAL
    
    lea dx, newline
    call printDX
    
    lea dx, msg2            ; print Trang thai capslock:
    call printDX      
    
    mov al, bh              ; print state
    call printNumberAL                
      
    
    ; cl = 1 neu bh = bl = 1
    mov cl, bl
    and cl, bh
    
    mov ah, 2
    mov dl, 10
    int 21h         
    
    call showClock
    jmp exit
    
    ; neu ca 2 den deu sang
    cmp cl, 1
    jne test_num
    
    call showClock
    
    jmp exit
                      
; neu den numlock sang    
test_num:     
    cmp bl, 1
    jne test_caps
    
    call calculate2Num
     
    jmp exit

; neu den capslock sang
test_caps:     
    cmp bh, 1
    jne none          
    
    call printRect
    
    jmp exit

; neu khong den nao sang
none:
    lea dx, msg_none
    call printDX
    
exit:    
    mov ah, 4ch
    int 21h

endp
ends 
 
end main ; set entry point and stop the assembler.
