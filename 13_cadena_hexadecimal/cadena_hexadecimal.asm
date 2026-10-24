; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 13 - Obtención de una cadena hexadecimal
; Descripción: Programa que convierte un número de 32 bits (DWORD) en su representación 
;              como cadena de texto en formato hexadecimal, utilizando operaciones 
;              lógicas (AND) y desplazamientos (SHR) para extraer cada nibble.

INCLUDE Irvine32.inc

.data
    bufferHex BYTE 9 DUP(0)  ; Buffer de 8 caracteres hex + 1 terminador nulo (0)

.code
main PROC
    ; Limpiamos los registros principales
    mov eax, 0
    mov ebx, 0
    mov ecx, 0
    mov edx, 0

    mov eax, 2AB34CD0h       ; Número hexadecimal que vamos a convertir
    mov esi, 7               ; Empezamos a guardar desde el final del buffer (posición 7)
    mov ecx, 8               ; Un DWORD tiene 8 nibbles (dígitos hex) en total

L1:
    ; 1. Extraer el nibble menos significativo (los últimos 4 bits)
    mov ebx, eax
    and ebx, 0Fh             ; La máscara 0Fh (00001111b) aísla el último dígito hex

    ; 2. Convertir el valor numérico a carácter ASCII
    cmp ebx, 10
    jl EsNumero              ; Si es del 0 al 9, salta directamente
    add ebx, 7               ; Si es de 10 a 15 (A-F), se le suma 7 para saltar los caracteres
                             ; de la tabla ASCII entre '9' (57) y 'A' (65)

EsNumero:
    add ebx, '0'             ; Sumamos '0' (48) para obtener el código ASCII correcto
    mov bufferHex[esi], bl   ; Guardamos el carácter en el buffer (de atrás hacia adelante)
    
    ; 3. Preparar el siguiente nibble
    shr eax, 4               ; Desplazamos EAX 4 bits a la derecha (eliminamos el nibble procesado)
    dec esi                  ; Retrocedemos una posición en el buffer
    loop L1                  ; El bucle se repite 8 veces (ECX)

    ; 4. Mostrar el resultado
    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    call DumpRegs
    
    exit                     ; Cierra el programa correctamente
main ENDP
END main
