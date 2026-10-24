; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 10 - Obtención de una cadena decimal
; Descripción: Programa que realiza operaciones aritméticas sobre datos de descarga y 
;              utiliza una subrutina propia (convertirDecimal) para transformar los 
;              resultados numéricos en cadenas de texto y poder imprimirlos en pantalla.

INCLUDE Irvine32.inc

.data
    ; Datos proincipales
    ; Datos del problema (simulación de descarga)
    tamArchivo DWORD 100000      ; El archivo pesa 100,000 bytes en total
    bloques DWORD 125            ; Llevamos 125 bloques descargados
    tamBloque DWORD 512          ; Cada bloque pesa 512 bytes

    ; Variables para guardar los resultados de las operaciones
    descargados DWORD ?          ; Cuánto llevamos bajado
    pendientes DWORD ?           ; Cuánto falta por bajar
    porcentaje DWORD ?           ; Qué tanto por ciento llevamos
    grupos DWORD ?               ; Cuántos grupos de 1024 bytes caben
    residuo DWORD ?              ; Lo que sobra al hacer los grupos

    ; Mensajes que van a salir en pantalla
    msg1 BYTE "Bytes descargados: ",0
    msg2 BYTE "Bytes pendientes: ",0
    msg3 BYTE "Porcentaje de avance: ",0
    msg4 BYTE "Grupos completos de 1024: ",0
    msg5 BYTE "Residuo del agrupamiento: ",0
    salto BYTE 13,10,0           ; Salto de línea alternativo

    ; Buffer de 11 espacios para armar los números como texto
    buffer BYTE 11 DUP(0)

.code


convertirDecimal PROC
    ; Guardamos los registros en la pila para no alterar el flujo principal
    push eax
    push ebx
    push ecx
    push edx
    push edi

    mov edi, esi
    add edi, 10                  ; Nos posicionamos al final del buffer
    mov BYTE PTR [edi], 00h      ; Agregamos el terminador nulo (fin de cadena)

    mov ebx, 10                  ; Vamos a dividir entre 10 para sacar los dígitos

    ; Si el número es cero, es un caso especial
    cmp eax, 0
    jne convertir
    dec edi
    mov BYTE PTR [edi], '0'
    jmp terminado

convertir:
    ; Aquí sacamos el último dígito del número
    xor edx, edx
    div ebx                      ; Dividimos entre 10. El residuo (dígito) cae en EDX
    
    add dl, '0'                  ; Convertimos el dígito numérico a su valor ASCII ('0' a '9')
    dec edi                      ; Nos movemos un espacio a la izquierda en el buffer
    mov [edi], dl                ; Guardamos el carácter

    cmp eax, 0
    jne convertir                ; Si aún queda número, repetimos el ciclo

terminado:
    ; Como armamos el texto de atrás hacia adelante, hay que moverlo al inicio del buffer
    mov esi, edi
    mov ecx, 0

contar:
    cmp BYTE PTR [esi+ecx], 0    ; Contamos cuántas letras armamos
    je copiarInicio
    inc ecx
    jmp contar

copiarInicio:
    mov edi, OFFSET buffer
    inc ecx                      ; Incluimos el terminador nulo en la copia
    cld
    rep movsb                    ; Copiamos la cadena al inicio del buffer

    ; Restauramos los registros originales desde la pila
    pop edi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
convertirDecimal ENDP


; PROGRAMA PRINCIPAL

main PROC

    ; --- 1. Calcular bytes descargados ---
    mov eax, bloques
    mul tamBloque                ; EAX = bloques * tamBloque
    mov descargados, eax         ; Guardamos el resultado

    ; --- 2. Calcular bytes pendientes ---
    mov eax, tamArchivo
    sub eax, descargados         ; EAX = total - descargados
    mov pendientes, eax          ; Guardamos cuánto falta

    ; --- 3. Calcular porcentaje de avance ---
    mov eax, descargados
    mov ebx, 100
    mul ebx                      ; descargados * 100
    mov ebx, tamArchivo
    div ebx                      ; (descargados * 100) / total
    mov porcentaje, eax

    ; --- 4. Calcular grupos de 1024 y residuo ---
    mov eax, descargados
    xor edx, edx                 ; Limpiamos EDX para la división
    mov ebx, 1024
    div ebx                      ; EAX = grupos, EDX = residuo
    mov grupos, eax
    mov residuo, edx

    
    ; IMPRESIÓN DE RESULTADOS
    

    ; Mostrar bytes descargados
    mov edx, OFFSET msg1         
    call WriteString             
    mov eax, descargados         
    mov esi, OFFSET buffer
    call convertirDecimal        
    mov edx, OFFSET buffer
    call WriteString             
    call Crlf                    

    ; Mostrar bytes pendientes
    mov edx, OFFSET msg2
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Mostrar porcentaje
    mov edx, OFFSET msg3
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    mov edx, OFFSET salto        
    call WriteString

    ; Mostrar grupos completos
    mov edx, OFFSET msg4
    call WriteString
    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Mostrar residuo
    mov edx, OFFSET msg5
    call WriteString
    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP
END main
