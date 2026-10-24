; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 2 - Captura y desplegado de mensajes
; Descripción: Programa que solicita un nombre al usuario, lo captura, lo imprime en 
;              pantalla junto con el número de caracteres escritos y muestra el tamaño 
;              de un arreglo de prueba.

INCLUDE Irvine32.inc

.data
    mensajeEntrada BYTE "Escribe tu nombre: ", 0
    nombre BYTE 10 DUP(0)                   ; Buffer de 10 bytes para guardar el nombre
    caracteresEscritos BYTE "Numero de caracteres: ", 0
    experimento BYTE 50 DUP("a"), "b", 0    ; Arreglo de prueba (50 letras 'a', una 'b' y el nulo)

.code 
main PROC
    ; 1. Desplegar el mensaje pidiendo el nombre
    mov edx, OFFSET mensajeEntrada
    call WriteString

    ; 2. Configurar la captura de la cadena
    mov edx, OFFSET nombre          ; EDX apunta a donde se guardará el texto
    mov ecx, SIZEOF nombre          ; ECX indica el tamaño máximo permitido (10)
    call ReadString                 ; Lee el teclado. Al terminar, EAX contiene la longitud del texto escrito

    ; 3. Imprimir el nombre que el usuario ingresó
    mov edx, OFFSET nombre
    call WriteString
    call Crlf

    ; 4. Imprimir el mensaje de "Numero de caracteres: "
    mov edx, OFFSET caracteresEscritos
    call WriteString
    
    ; 5. Imprimir la cantidad de caracteres
    ; Nota: ReadString guarda automáticamente la longitud en el registro EAX.
    call WriteDec
    call Crlf

    ; 6. Imprimir el arreglo de prueba ('aaaa...b')
    mov edx, OFFSET experimento
    call WriteString
    call Crlf

    ; 7. Imprimir el tamaño total en bytes del arreglo experimento
    ; SIZEOF calcula el tamaño en bytes (50 'a' + 1 'b' + 1 nulo = 52 bytes)
    mov eax, SIZEOF experimento
    call WriteDec

    exit
main ENDP
END main
