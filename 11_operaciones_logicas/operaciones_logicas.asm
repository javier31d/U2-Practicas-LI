; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 11 - Operaciones lógicas
; Descripción: Programa que simula el panel de control de un sistema mediante el uso 
;              de operaciones lógicas a nivel de bits (AND, OR) para consultar y modificar 
;              estados específicos (encendido, alarma, conexión).

INCLUDE Irvine32.inc

.data
; No se requieren variables globales para esta práctica.

.code
main PROC
    
    ; Simulación de un panel de control con bits:
    ; Bit 0 - Encendido
    ; Bit 1 - Alarma
    ; Bit 2 - Conectada
    ; Estado inicial: 00000101b (Encendido y Conectada)

    ; --- 1. OPERACIÓN AND: Extraer el estado de "Encendido" ---
    ; La instrucción AND sirve para "enmascarar" y leer un bit específico.
    mov eax, 0
    mov ebx, 0
    mov al, 00000101b       ; Estado actual del sistema
    mov bl, al
    
    ; Hacemos un AND con 00000001b.
    ; Como el Bit 0 es 1, el resultado será 1. Si hubiera sido 0, el resultado sería 0.
    and bl, 00000001b       

    call dumpRegs           ; Mostramos los registros. BL debería valer 1 (00000001b)
    nop

    ; --- 2. OPERACIÓN OR: Encender la "Alarma" ---
    ; La instrucción OR sirve para "encender" un bit específico sin importar cómo esté.
    mov al, 00000101b       ; Volvemos al estado inicial
    ; Hacemos un OR con 00000010b. Esto forzará a que el Bit 1 se vuelva 1.
    or al, 00000010b        ; El nuevo estado será 00000111b (Encendido, Alarma y Conectada)

    call dumpRegs           ; Mostramos los registros. AL debería valer 7 (00000111b)
    nop 
    
    exit
main ENDP
END main
