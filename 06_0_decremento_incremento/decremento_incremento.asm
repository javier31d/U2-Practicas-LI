; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6 - Decremento e incremento
; Descripción: Sistema de validación de PIN que permite un máximo de 3 intentos. 
;              Utiliza la instrucción DEC para decrementar el contador de intentos 
;              cada vez que el usuario ingresa un PIN incorrecto.

INCLUDE Irvine32.inc

.data
    msgPIN BYTE "Ingrese el PIN de acceso: ", 0

    msgError BYTE "***PIN INCORRECTO***", 0
    msgAcceso BYTE "ACCESO PERMITIDO.", 0
    msgIntentos BYTE "Intentos restantes: ", 0
    msgBloqueo BYTE "********************************Se ha bloqueado el sistema por exceso de intentos********************************", 0

    pinCorrecto = 1234      ; Constante que define el PIN válido

.code 
main PROC
    mov ebx, 3              ; Inicializamos EBX con 3 intentos disponibles

inicio:
    ; 1. Pedir el PIN al usuario
    mov edx, OFFSET msgPIN
    call WriteString
    call ReadInt            ; Lee el número y lo guarda en EAX
    call Crlf

    ; 2. Comparar el PIN ingresado con el correcto
    cmp eax, pinCorrecto
    je acceso               ; Si es igual, salta a la etiqueta 'acceso'

    ; 3. Si el PIN es incorrecto, decrementamos los intentos
    DEC ebx                 ; Decrementa EBX en 1 (EBX = EBX - 1)
    
    ; Mostrar mensaje de error
    mov edx, OFFSET msgError
    call WriteString
    call Crlf

    ; Mostrar cuántos intentos quedan
    mov edx, OFFSET msgIntentos
    call WriteString
    mov eax, ebx            ; Pasamos el número de intentos a EAX para imprimirlo
    call WriteDec
    call Crlf

    ; 4. Verificar si ya no quedan intentos
    cmp ebx, 0
    je bloqueo              ; Si EBX llega a 0, salta a 'bloqueo'
    
    ; 5. Si aún hay intentos, volver a pedir el PIN
    jmp inicio              ; Salto incondicional al inicio del ciclo


acceso:
    ; Bloque de código si el PIN es correcto
    mov edx, OFFSET msgAcceso
    call WriteString
    call Crlf
    exit

bloqueo:
    ; Bloque de código si se agotan los intentos
    mov edx, OFFSET msgBloqueo
    call WriteString
    call Crlf
    exit

main ENDP
END main
