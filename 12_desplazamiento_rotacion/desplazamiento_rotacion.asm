; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 12 - Desplazamiento y rotación
; Descripción: Programa que demuestra el uso de las instrucciones de desplazamiento 
;              de bits (SHL, SHR, SAR) y rotación (ROL, ROR), mostrando cómo 
;              modifican los valores de los registros y las banderas.

INCLUDE Irvine32.inc

.data
; No se requieren variables globales.

.code
main PROC
    ; Limpiamos los registros principales para empezar en ceros
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    ; --- 1. SHL: Desplazar una posición a la izquierda (Shift Left) ---
    ; Multiplica por 2. El bit que sale por la izquierda entra a la bandera CF.
    mov al, 10000000b
    shl al, 1           ; AL = 00000000b (y CF = 1)

    call DumpRegs
    call WriteBin
    call Crlf
    
    ; --- 2. SHR: Desplazar una posición a la derecha (Shift Right) ---
    ; Divide entre 2. El bit que sale por la derecha entra a CF.
    mov al, 00001101b
    shr al, 1           ; AL = 00000110b (y CF = 1)
    
    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 3. SAR: Desplazamiento aritmético a la derecha (Conserva el signo) ---
    ; Rellena con el bit de signo (1 si es negativo).
    mov al, -8          ; -8 en binario es 11111000b
    sar al, 1           ; AL = 11111100b (-4)
    
    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 4. SAR: Con operaciones no exactas ---
    ; Al ser negativo y no exacto, el bit de signo se mantiene.
    mov al, -9          ; -9 en binario es 11110111b
    sar al, 1           ; AL = 11111011b (-5)
    
    call DumpRegs
    call WriteBin
    call Crlf

    ; --- 5. Desplazar 2 bits hacia la izquierda (SHL) ---
    ; Es equivalente a multiplicar por 4 (2^2).
    mov al, 00001111b   ; 15 en decimal
    shl al, 2           ; AL = 00111100b (60 en decimal)

    call WriteBin
    call DumpRegs
    call Crlf

    ; --- 6. Desplazar usando el registro CL ---
    ; Cuando el desplazamiento es variable, se usa CL.
    mov al, 00001111b   ; 15 en decimal
    mov cl, 2           ; Desplazaremos 2 posiciones
    shr al, cl          ; AL = 00000011b (3 en decimal)
    
    call WriteBin
    call DumpRegs
    call Crlf

    ; --- 7. ROTACIONES (ROL y ROR) ---
    ; A diferencia de los desplazamientos, los bits que salen vuelven a entrar por el otro lado.
    
    ; ROL (Rotate Left): El bit más a la izquierda pasa a la derecha.
    mov al, 10000001b
    rol al, 1           ; AL = 00000011b (el 1 de la izquierda pasó a la derecha)

    ; ROR (Rotate Right): El bit más a la derecha pasa a la izquierda.
    mov al, 00000011b
    ror al, 1           ; AL = 10000001b (el 1 de la derecha pasó a la izquierda)

    call DumpRegs
    call WriteBin

    ; Limpiamos la bandera de acarreo (Carry Flag) para finalizar
    clc
    
    exit
main ENDP
END main
