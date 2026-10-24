; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5.1 - Repetir hasta que el usuario ingrese cero
; Descripción: Programa que solicita números continuamente mediante un ciclo. 
;              El ciclo finaliza (sale del programa) únicamente cuando el usuario ingresa un 0.

INCLUDE Irvine32.inc

.data
; No se requieren variables globales para esta práctica.

.code
main PROC
ciclo:
    ; 1. Capturamos un número entero desde el teclado
    ; Nota: ReadInt guarda el valor ingresado directamente en el registro EAX
    call ReadInt
    call Crlf

    ; 2. Comparamos el valor ingresado con 0
    cmp eax, 0
    
    ; 3. Si el número es igual a 0 (Zero Flag activada), salta a la etiqueta 'Salir'
    je Salir      
    
    ; (Opcional) Aquí podrías agregar código para hacer una operación con el número antes de repetir
    
    ; 4. Si no es 0, el salto incondicional vuelve al inicio a pedir otro número
    jmp ciclo     

Salir:
    ; Termina la ejecución del programa cuando se ingresa un 0
    exit
main ENDP
END main
