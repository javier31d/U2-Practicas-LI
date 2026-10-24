; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 9 - PUSH y POP
; Descripción: Programa que demuestra el funcionamiento de la pila (Stack) utilizando 
;              PUSH y POP, el orden LIFO, el respaldo de registros y el uso de CALL y RET.

INCLUDE Irvine32.inc

.data


.code
main PROC

    
    ; BLOQUE 1: PUSH Y POP BÁSICO
    
    mov eax, 500        ; Metemos el número 500 en EAX

    push eax            ; Guardamos ese 500 en la pila (como meterlo a un cajón)
    nop

    mov ebx, 0          ; Limpiamos EBX para que valga 0
    pop ebx             ; Sacamos el valor del cajón y lo ponemos en EBX. ¡Ahora EBX vale 500!

    nop

    
    ; BLOQUE 2: ORDEN LIFO (Last In, First Out)
    
    mov eax, 10         
    push eax            ; Metemos el 10 a la pila

    mov eax, 20
    push eax            ; Ahora metemos el 20

    mov eax, 30
    push eax            ; Y al final metemos el 30

    nop

    ; ¡A sacar todo! Como el 30 fue el último en entrar, es el primero en salir.
    pop eax             ; EAX se lleva el 30
    pop ebx             ; EBX se lleva el 20
    pop ecx             ; ECX se lleva el 10
    
    nop


    ; BLOQUE 3: CONSERVAR REGISTROS (Respaldo)

    mov eax, 100        ; Tenemos datos importantes en EAX
    mov ebx, 200        ; Y también en EBX

    push eax            ; Respaldamos EAX en la pila
    push ebx            ; Respaldamos EBX en la pila

    mov eax, 999        ; Ahora cambiamos los valores temporalmente
    mov ebx, 888    

    ; Ahora recuperamos los valores originales que habíamos guardado
    pop ebx             ; EBX vuelve a ser 200
    pop eax             ; EAX vuelve a ser 100

    nop

    
    ; BLOQUE 4: CALL Y RET
    
    mov eax, 50         ; Preparamos un 50
    mov ebx, 666        ; Y preparamos un 666

    call aumentarDiez   ; Nos saltamos al procedimiento de abajo para sumar 10

    nop

    exit
main ENDP


; Procedimiento que suma 10 a EAX, pero protege el valor de EBX
aumentarDiez PROC    
    nop
    push ebx            ; Primero guardamos el valor que traía EBX (666) para no perderlo
    nop

    mov ebx, 10         ; Metemos un 10 en EBX
    add eax, ebx        ; Sumamos: EAX (que era 50) + 10 = 60
    
    nop

    pop ebx             ; Recuperamos el EBX original (vuelve a ser 666)
    nop

    ret                 ; Regresamos al lugar exacto donde nos llamaron
aumentarDiez ENDP
END main
