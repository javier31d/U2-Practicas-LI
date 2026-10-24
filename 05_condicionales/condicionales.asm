; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 5 - Condicionales
; Descripción: Programa que utiliza comparaciones y saltos condicionales para simular 
;              un ciclo, imprimiendo en pantalla los números del 1 al 10.

INCLUDE Irvine32.inc

.data
; No se requieren variables globales para esta práctica.

.code
main PROC
    mov ebx, 1              ; Inicializamos EBX en 1 (será nuestro contador)

ciclo:
    cmp ebx, 10             ; Comparamos el contador (EBX) con el límite (10)
    
    ; Si EBX es mayor que 10, salta a la etiqueta 'fin' para terminar el programa
    jg fin                  

    ; Si no ha saltado, copiamos el valor de EBX a EAX para mostrarlo
    mov eax, ebx            
    call WriteDec           ; Despliega el número actual en consola
    call Crlf               ; Realiza un salto de línea

    inc ebx                 ; Incrementa el contador EBX en 1 (EBX = EBX + 1)

    ; Salto incondicional para volver al inicio del ciclo y evaluar de nuevo
    jmp ciclo               

fin:
    exit                    ; Finaliza la ejecución del programa
main ENDP
END main
