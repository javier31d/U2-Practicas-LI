; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 6.1 - Control de ocupación de un estacionamiento
; Descripción: Sistema gestor de estacionamiento. Permite ingresar o extraer autos, 
;              actualizando los espacios libres con incrementos (INC) y decrementos (DEC), 
;              validando que no se exceda la capacidad ni se saquen autos de más.

INCLUDE Irvine32.inc

.data
    msgInicial BYTE "BIENVENIDO AL SISTEMA GESTOR DEL ESTACIONAMIENTO", 0
    msgEspaciosLibres BYTE "Cantidad de espacios libres actualmente: ", 0 
    msgLleno BYTE "NO SE PUEDE INGRESAR EL ESTACIONAMIENTO ESTA LLENO", 0
    msgCerrar BYTE "El programa se cerrara, gracias por usar el sistema", 0
    msgInstruccion BYTE "Por favor ingrese un 1 para ingresar un auto, 2 para extraer un auto y 0 para salir del programa", 0
    msgVacio BYTE "NO PUEDE SACAR MAS AUTOS, EL ESTACIONAMIENTO ESTA VACIO", 0

    espaciosMaximos = 10
    espaciosLibres DWORD ?

.code 
main PROC
    ; Inicializamos el estacionamiento con el total de espacios disponibles
    mov espaciosLibres, espaciosMaximos
    
    ; Mostrar mensaje de bienvenida
    mov edx, OFFSET msgInicial
    call WriteString
    call Crlf

Ciclo:
    ; Mostrar cuántos espacios libres hay actualmente
    mov edx, OFFSET msgEspaciosLibres
    call WriteString

    mov eax, espaciosLibres
    call WriteDec
    call Crlf
    
    ; Mostrar el menú de instrucciones
    mov edx, OFFSET msgInstruccion
    call WriteString
    call Crlf
    
    ; Leer la opción del usuario (1 = Ingresar, 2 = Extraer, Otro = Salir)
    call ReadInt
    
    cmp eax, 1
    je Agregar
    cmp eax, 2
    je Quitar
    jmp Salir       ; Si no es 1 ni 2, sale del programa

Agregar:
    ; Validar si hay espacios disponibles
    cmp espaciosLibres, 0
    je Lleno        ; Si es 0, el estacionamiento está lleno
    DEC espaciosLibres  ; Restamos un espacio libre
    jmp Ciclo       ; Volver al menú

Lleno:
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf
    jmp Salir       ; Salir del programa si está lleno

Vacio:
    mov edx, OFFSET msgVacio
    call WriteString
    call Crlf
    jmp Ciclo       ; Volver al menú

Quitar:
    ; Validar si hay autos para sacar (si los espacios libres son iguales al máximo, está vacío)
    cmp espaciosLibres, 10
    je Vacio
    INC espaciosLibres  ; Sumamos un espacio libre (sale un auto)
    jmp Ciclo       ; Volver al menú

Salir:
    mov edx, OFFSET msgCerrar
    call WriteString
    call Crlf
    exit

main ENDP
END main
