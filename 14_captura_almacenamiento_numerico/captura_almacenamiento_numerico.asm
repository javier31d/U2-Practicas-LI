; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 14 - Captura y almacenamiento de datos numéricos
; Descripción: Programa que solicita una cantidad (1-99) al usuario. Valida que la entrada 
;              solo contenga números, convierte la cadena a un valor numérico real, lo suma 
;              a una existencia inicial y muestra el resultado convirtiéndolo de nuevo a texto.

INCLUDE Irvine32.inc

.data
    promptMsg         BYTE "Ingrese la cantidad recibida (1-99): ", 0
    errorMsg          BYTE "Error de entrada. Intente nuevamente.", 0
    msgExistencia     BYTE "Existencia actual: ", 0

    buffer            BYTE 10 DUP(0)
    cantidadRecibida  DWORD ?
    existenciaInicial DWORD 25
    existenciaActual  DWORD ?
    outBuffer         BYTE 10 DUP(0)

.code
main PROC
PedirDatos:
    ; 1. Pedir los datos al usuario
    mov edx, OFFSET promptMsg
    call WriteString

    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer
    call ReadString

    ; 2. Validar longitud EAX = número de caracteres leídos
    cmp eax, 0
    je  ErrorEntrada
    cmp eax, 2
    ja  ErrorEntrada        ; Si tiene más de 2 caracteres, es error

    ; 3. Validar que todos los caracteres sean dígitos del '0' al '9'
    mov esi, OFFSET buffer
    mov ecx, eax
ValidarCaracteres:
    mov al, [esi]
    cmp al, '0'
    jb  ErrorEntrada        ; Si es menor al ASCII '0'
    cmp al, '9'
    ja  ErrorEntrada        ; Si es mayor al ASCII '9'
    inc esi
    loop ValidarCaracteres

    ; 4. Convertir de ASCII a número real
    mov esi, OFFSET buffer
    mov eax, 0
    mov ecx, 2
ConvertLoop:
    movzx edx, BYTE PTR [esi]
    cmp dl, 0
    je  FinConversion       ; Si llegamos al terminador nulo, terminamos
    sub dl, '0'             ; Convertimos el carácter ASCII a su valor numérico (ej. '5' -> 5)
    movzx edx, dl
    imul eax, eax, 10       ; Multiplicamos el acumulado por 10 (para agregar el nuevo dígito)
    add eax, edx            ; Sumamos el dígito actual
    inc esi
    loop ConvertLoop

FinConversion:
    ; 5. Validar rango 1 al 99 (por si acaso)
    cmp eax, 1
    jb  ErrorEntrada
    cmp eax, 99
    ja  ErrorEntrada

    ; 6. Calcular existencia actual (Inicial + Recibida)
    mov cantidadRecibida, eax
    mov ebx, existenciaInicial
    add eax, ebx
    mov existenciaActual, eax

    ; 7. Mostrar el resultado
    mov edx, OFFSET msgExistencia
    call WriteString

    mov eax, existenciaActual
    mov edi, OFFSET outBuffer
    call ConvDwordToString  ; Convertimos el número a texto

    mov edx, OFFSET outBuffer
    call WriteString
    call Crlf
    jmp FinProg

ErrorEntrada:
    ; Manejo de errores (si el usuario escribe letras o números fuera de rango)
    call Crlf
    mov edx, OFFSET errorMsg
    call WriteString
    call Crlf
    jmp PedirDatos          ; Vuelve a pedir los datos

FinProg:
    exit
main ENDP


; Convierte el número en EAX  a una cadena de texto ASCII
; apuntada por EDI. Utiliza la pila para guardar los dígitos en orden inverso.

ConvDwordToString PROC
    pushad
    mov ecx, 0
    mov ebx, 10
DivLoop:
    mov edx, 0
    div ebx                     ; EDX:EAX / 10 EAX = cociente, EDX = residuo
    add dl, '0'                 ; Convertimos el dígito numérico a ASCII
    push edx                    ; Guardamos el dígito en la pila
    inc ecx                     ; Contamos cuántos dígitos llevamos
    cmp eax, 0
    jne DivLoop

PopLoop:
    pop edx                     ; Sacamos los dígitos en orden correcto
    mov [edi], dl
    inc edi
    loop PopLoop

    mov BYTE PTR [edi], 0       ; Agregamos el terminador nulo
    popad
    ret
ConvDwordToString ENDP

END main
