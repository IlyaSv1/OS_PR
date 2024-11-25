org 7C00h

jmp start

fio:    db 'Svintsov I.S. NMT-323901',0

start:
        ; Óñòàíîâêà ãðàôè÷åñêîãî ðåæèìà
        mov ah, 00h
        mov al, 13h
        int 10h

        ; Âûâîä òåêñòà â ïðàâîì íèæíåì óãëó
        mov si, fio
        mov dl, 55             ; Êîîðäèíàòà X
        mov dh, 23             ; Êîîðäèíàòà Y
text_loop:
        mov bh, 0
        mov ah, 02h
        int 10h                ; Óñòàíàâëèâàåì êóðñîð
        mov al, [cs:si]
        cmp al, 0              ; Ïðîâåðêà íà êîíåö ñòðîêè
        je draw_oval
        mov bl, 47h            ; Öâåò òåêñòà
        mov bh, 0
        mov ah, 0Eh            ; Âûâîä ñèìâîëà
        int 10h
        inc dl                 ; Ñìåùàåì êóðñîð âïðàâî
        inc si
        jmp text_loop

draw_oval:
        ; Ðèñóåì îâàë â ëåâîì âåðõíåì óãëó
        mov si, positions
oval_loop:
        mov ah, 0Ch            ; Ôóíêöèÿ ðèñîâàíèÿ ïèêñåëÿ
        mov bh, 0              ; Íîìåð ñòðàíèöû
        mov cx, [cs:si]        ; Çàãðóæàåì êîîðäèíàòó X
        cmp cx, 0              ; Ïðîâåðêà íà êîíåö äàííûõ
        je exit
        add si, 2
        mov dx, [cs:si]        ; Çàãðóæàåì êîîðäèíàòó Y
        add si, 2
        mov al, 47h            ; Öâåò ïèêñåëÿ (êðàñíûé)
        int 10h
        jmp oval_loop

positions:
        dw 5, 1
        dw 6, 1
        dw 7, 1
        dw 8, 1
        dw 9, 1
        dw 10, 1
        dw 11, 2
        dw 12, 2
        dw 13, 3
        dw 14, 4
        dw 14, 5
        dw 14, 6
        dw 13, 7
        dw 12, 8
        dw 11, 8
        dw 10, 9
        dw 9, 9
        dw 8, 9
        dw 7, 9
        dw 6, 9
        dw 5, 9
        dw 4, 8
        dw 3, 8
        dw 2, 7
        dw 1, 6
        dw 1, 5
        dw 1, 4
        dw 2, 3
        dw 3, 2
        dw 4, 2
        dw 0

exit:
        jmp $                  ; Áåñêîíå÷íûé öèêë

times 510 - ($ - $$) db 0      ; Çàïîëíåíèå äî 510 áàéò
dw 0AA55h                      ; Ñèãíàòóðà çàãðóçî÷íîãî ñåêòîðà
