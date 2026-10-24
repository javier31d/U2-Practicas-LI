; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 1 - Ciclos numéricos
; Descripción: Programa que utiliza la instrucción LOOP para imprimir en pantalla 
;              una cuenta regresiva del 5 al 1, utilizando la librería Irvine32.

INCLUDE Irvine32.inc

.data

.code 
main PROC
    ; Inicializamos el registro de  ECX con el número de iteraciones (5)
    mov ecx, 5

ciclo:
    ; Movemos el valor actual de ECX a EAX para poder imprimirlo
    mov eax, ecx
    
    ; Imprime el valor de EAX en consola como número decimal
    call WriteDec     
    
    ; Se realiza  el salto de línea para que el siguiente número se imprima abajo
    call Crlf         
    
    ; La instrucción LOOP decrementa ECX automáticamente y salta a la etiqueta 'ciclo'
    ; siempre y cuando ECX no sea igual a cero.
    loop ciclo 
    
    ; Finaliza la ejecución del programa
    exit 

main ENDP
END main
