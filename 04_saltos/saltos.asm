; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 4 - Saltos
; Descripción: Programa que demuestra el uso del salto incondicional (JMP) para 
;              alterar el flujo de ejecución, ignorando una asignación de valor.

INCLUDE Irvine32.inc

.code 
main PROC
    ; Asignamos el valor inicial 5 a EAX
    mov eax, 5
    
    ; JMP realiza un salto incondicional a la etiqueta "continuar".
    ; Esto provoca que se salte la siguiente instrucción.
    jmp continuar
    
    ; Esta línea NUNCA se ejecutará porque el JMP se la salta.
    mov eax, 10
    
continuar:
    ; Al llegar aquí, EAX sigue valiendo 5.
    ; DumpRegs mostrará los registros para comprobar el valor de EAX.
    call DumpRegs
    
    exit
main ENDP
END main
