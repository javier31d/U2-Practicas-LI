; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4.1 - Mayor, menor o igual con entrada del usuario
; Descripción: Programa que solicita dos números al usuario, los compara y 
;              determina si el primero es mayor, menor o igual al segundo.

INCLUDE Irvine32.inc

.data
    mensajeNum1 BYTE "Ingrese el num1: ", 0
    mensajeNum2 BYTE "Ingrese el num2: ", 0
    msgmayor BYTE "El num1 es mayor", 0
    msgmenor BYTE "El num1 es menor", 0
    msgigual BYTE "Los numeros son iguales", 0

    num1 DWORD ?
    num2 DWORD ?

.code 
main PROC
    ; --- CAPTURA DEL PRIMER NÚMERO ---
    mov edx, OFFSET mensajeNum1
    call WriteString
    
    mov edx, OFFSET num1
    call ReadInt            ; Lee el número desde el teclado y lo guarda en EAX
    mov num1, eax           ; Guardamos el valor de EAX en la variable num1
    call Crlf

    ; --- CAPTURA DEL SEGUNDO NÚMERO ---
    mov edx, OFFSET mensajeNum2
    call WriteString

    mov edx, OFFSET num2
    call ReadInt            ; Lee el segundo número
    mov num2, eax           ; Guardamos el valor en num2
    call Crlf

    ; --- COMPARACIÓN ---
    mov eax, num1           ; Cargamos num1 en EAX
    mov ebx, num2           ; Cargamos num2 en EBX

    cmp eax, ebx            ; Compara EAX con EBX

    jg mayor                ; Salta a 'mayor' si EAX > EBX (num1 > num2)
    jl menor                ; Salta a 'menor' si EAX < EBX (num1 < num2)
    je igual                ; Salta a 'igual' si EAX == EBX (num1 == num2)

    ; --- ETIQUETAS DE RESPUESTA ---
mayor:
    mov edx, OFFSET msgmayor
    call WriteString
    jmp fin                 ; Salta al final para no ejecutar los otros mensajes

menor:
    mov edx, OFFSET msgmenor
    call WriteString
    jmp fin

igual:
    mov edx, OFFSET msgigual
    call WriteString
    jmp fin

fin:
    call Crlf
    exit
main ENDP
END main
