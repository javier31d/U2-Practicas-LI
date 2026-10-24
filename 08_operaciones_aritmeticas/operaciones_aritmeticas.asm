; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 8 - Operaciones aritméticas
; Descripción: Programa que demuestra el uso de instrucciones aritméticas básicas (ADD, SUB, 
;              MUL, IMUL, DIV, IDIV) y cómo afectan los registros y las banderas del procesador.

INCLUDE Irvine32.inc

.code 
main PROC
    ; --- 1. SUMA Y RESTA (ADD y SUB) ---
    mov eax, 50
    mov ebx, 20
    add eax, ebx        ; EAX = 50 + 20 = 70
    sub eax, 15         ; EAX = 70 - 15 = 55
    nop                 ; Instrucción nula (no hace nada, útil para pausar o alinear)

    ; --- 2. CARRY FLAG (CF): ACARREO EN SUMA SIN SIGNO ---
    mov eax, 0
    mov al, 255         ; AL = 255 (Máximo valor sin signo en 8 bits)
    add al, 1           ; Al sumar 1, se desborda el límite de 8 bits y activa CF (Carry Flag)

    ; --- 3. OVERFLOW FLAG (OF): DESBORDAMIENTO EN SUMA CON SIGNO ---
    mov eax, 0
    mov al, 127         ; AL = 127 (Máximo valor positivo con signo en 8 bits)
    add al, 1           ; Al sumar 1, se vuelve -128 y activa OF (Overflow Flag)
    nop

    ; --- 4. MULTIPLICACIÓN SIN SIGNO (MUL) ---
    mov eax, 65532
    mov ebx, 65532
    mul ebx             ; Multiplica EAX por EBX. El resultado se guarda en EDX:EAX (por si es muy grande)

    ; --- 5. MULTIPLICACIÓN CON SIGNO (IMUL) ---
    mov eax, -5 
    imul eax, eax, 3    ; EAX = EAX * 3 (Multiplica -5 por 3, resultado en EAX)
    nop

    ; --- 6. DIVISIÓN SIN SIGNO (DIV) ---
    mov eax, 125        ; Dividendo
    mov edx, 0          ; Limpiamos EDX porque DIV usa EDX:EAX
    mov ebx, 12         ; Divisor
    div ebx             ; EAX = 10 (cociente), EDX = 5 (residuo)
    nop

    ; --- 7. DIVISIÓN CON SIGNO (IDIV) Y EXTENSIÓN DE SIGNO (CDQ) ---
    mov eax, -125       ; Dividendo negativo
    cdq                 ; Extiende el signo de EAX hacia EDX (prepara para IDIV)
    mov ebx, 12         ; Divisor
    idiv ebx            ; División con signo
    nop 

    ; --- MOSTRAR RESULTADOS ---
    call DumpRegs       ; Imprime el estado de todos los registros y banderas en pantalla
    call WaitMsg        ; Pausa el programa hasta que el usuario presione una tecla
    exit
main ENDP
END main
