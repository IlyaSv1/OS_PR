org 7C00h

jmp start

fio:    db 'Svintsov I.S. NMT-323901',0

start:
        ; Установка графического режима
        mov ah, 00h
        mov al, 13h
        int 10h

        ; Вывод текста в правом нижнем углу
        mov si, fio
        mov dl, 55             ; Координата X
        mov dh, 23             ; Координата Y
text_loop:
        mov bh, 0
        mov ah, 02h
        int 10h                ; Устанавливаем курсор
        mov al, [cs:si]
        cmp al, 0              ; Проверка на конец строки
        je draw_oval
        mov bl, 47h            ; Цвет текста
        mov bh, 0
        mov ah, 0Eh            ; Вывод символа
        int 10h
        inc dl                 ; Смещаем курсор вправо
        inc si
        jmp text_loop

draw_oval:
        ; Рисуем овал в левом верхнем углу
        mov si, positions
oval_loop:
        mov ah, 0Ch            ; Функция рисования пикселя
        mov bh, 0              ; Номер страницы
        mov cx, [cs:si]        ; Загружаем координату X
        cmp cx, 0              ; Проверка на конец данных
        je exit
        add si, 2
        mov dx, [cs:si]        ; Загружаем координату Y
        add si, 2
        mov al, 47h            ; Цвет пикселя (красный)
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
        jmp $                  ; Бесконечный цикл

times 510 - ($ - $$) db 0      ; Заполнение до 510 байт
dw 0AA55h                      ; Сигнатура загрузочного сектора