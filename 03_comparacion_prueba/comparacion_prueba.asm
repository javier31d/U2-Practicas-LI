; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 3 - Comparación y prueba
; Descripción: Programa que demuestra el funcionamiento de las instrucciones CMP y TEST,
;              mostrando cómo afectan los banderas (flags) del procesador mediante DumpRegs.

INCLUDE Irvine32.inc

.code 
main PROC
    ; --- CASO 1: Comparación de iguales (Zero Flag) ---
    mov eax, 10h
    cmp eax, 10h        ; Compara EAX con 10h. Al ser iguales, la bandera ZF (Zero Flag) se activa a 1.
    call DumpRegs       ; Muestra el estado de los registros y banderas.

    ; --- CASO 2: Comparación con signo (Sign y Overflow Flags) ---
    mov eax, 0
    mov ebx, 0
    mov al, -5          ; AL = -5 (FBh)
    mov bl, 1
    cmp al, bl          ; Compara -5 con 1. Al ser menor, la bandera SF (Sign Flag) se activa.
    call DumpRegs

    ; --- CASO 3: Comparación sin signo (Carry Flag) ---
    mov eax, 0
    mov ebx, 0
    mov al, 5
    mov bl, 10
    cmp al, bl          ; Compara 5 con 10. Como 5 < 10, se genera un "préstamo" y la bandera CF (Carry Flag) se activa a 1.
    call DumpRegs

    ; --- CASO 4: Desbordamiento (Overflow Flag) ---
    mov eax, 0
    mov ebx, 0
    mov al, -128        ; AL = -128 (80h)
    mov bl, 1
    cmp al, bl          ; Compara -128 con 1. El resultado de la resta (-129) excede el límite de 8 bits (-128 a 127), activando OF (Overflow Flag).
    call DumpRegs

    ; --- CASO 5: Instrucción TEST (Operación Lógica AND) ---
    mov eax, 5          ; EAX = 00000101 en binario
    test eax, 1         ; Hace un AND con 1 (00000001). Como el resultado es 1 (no cero), ZF se queda en 0.
    call DumpRegs

    ; Explicación del TEST:
    ; 00000101 (5)
    ; 00000001 (1)
    ; -------- (AND)
    ; 00000001 (Resultado)

    exit
main ENDP
END main
