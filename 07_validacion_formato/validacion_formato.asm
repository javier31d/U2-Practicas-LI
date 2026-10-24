; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 7 - Validación de formato
; Descripción: Programa que solicita una cadena al usuario y valida que cumpla con 
;              el formato específico: 3 letras mayúsculas, 1 guion (-) y 3 números.

INCLUDE Irvine32.inc

.data
    codigo BYTE 8 DUP(0)
    msgError BYTE "CADENA INVALIDA, INTENTE DE NUEVO", 0
    msgInicial BYTE "Ingrese una cadena de longitud 7, 3 letras mayusculas seguidas de 1 guion y luego 3 numeros", 0
    msgValido BYTE "SU CADENA ES VALIDA", 0

.code 
main PROC
ciclar:
    ; 1. Pedir la cadena al usuario
    mov ESI, 0              ; Inicializamos el índice ESI en 0 para recorrer la cadena
    mov edx, OFFSET msgInicial
    call WriteString
    call Crlf
    
    mov edx, OFFSET codigo
    mov ecx, SIZEOF codigo  ; Tamaño máximo de lectura (8 caracteres)
    call ReadString

validacion:
    ; 2. Cargar el carácter actual en AL y evaluar su posición
    mov AL, codigo[ESI]
    
    cmp ESI, 3
    jl letras               ; Si ESI < 3, debe ser una letra mayúscula
    je guion                ; Si ESI == 3, debe ser un guion
    cmp ESI, 6
    jg fin                  ; Si ESI > 6, terminamos la validación
    jmp digitos             ; Si ESI está entre 4 y 6, debe ser un dígito

letras:
    ; 3. Validar letras mayúsculas (ASCII 65 a 90)
    cmp al, 65              ; 'A'
    jl error
    cmp al, 90              ; 'Z'
    jg error
    INC ESI
    jmp validacion

guion:
    ; 4. Validar el guion (ASCII 45)
    cmp al, 45              ; '-'
    jne error
    INC ESI
    jmp validacion

digitos:
    ; 5. Validar dígitos (ASCII 48 a 57)
    cmp al, 48              ; '0'
    jl error
    cmp al, 57              ; '9'
    jg error
    INC ESI 
    jmp validacion

error:
    ; Si se comete un error, mostrar mensaje y volver a pedir la cadena
    mov edx, OFFSET msgError
    call WriteString
    call Crlf
    jmp ciclar

fin:
    ; Si se completa el recorrido sin errores, la cadena es válida
    mov edx, OFFSET msgValido
    call WriteString
    call Crlf
    exit

main ENDP
END main
