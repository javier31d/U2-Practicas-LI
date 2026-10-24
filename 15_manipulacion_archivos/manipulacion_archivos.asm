; Materia: Lenguajes de Interfaz
; Alumno: Oscar Javier Chaidez Salazar
; Horario: 9:00/10:00
; Docente: Dr. José Luis Medina Jiménez
; Práctica: 15 - Manipulación de archivos
; Descripción: Programa que crea un archivo de texto llamado "inventario.txt", 
;              escribe la cadena "125" en su interior, cierra el archivo y 
;              maneja los posibles errores del sistema (falta de espacio, permisos, etc.).

INCLUDE Irvine32.inc

INVALID_HANDLE_VALUE EQU -1

.data
    nombreArchivo   BYTE "inventario.txt", 0
    texto           BYTE "125", 0
    archivoHandle   HANDLE ?
    mensajeExito    BYTE "Archivo Guardado", 0
    mensajeError    BYTE "No se pudo guardar el archivo", 0

.code
main PROC
    ; --- 1. CREAR EL ARCHIVO ---
    mov edx, OFFSET nombreArchivo
    call CreateOutputFile
    cmp eax, INVALID_HANDLE_VALUE
    je  Error                   ; Si el handle es inválido, salta al error 
    mov archivoHandle, eax      ; Guardamos el handle  del archivo

    ; --- 2. ESCRIBIR EN EL ARCHIVO ---
    mov eax, archivoHandle
    mov edx, OFFSET texto
    mov ecx, SIZEOF texto - 1   ; Restamos 1 para no escribir el terminador nulo (0)
    call WriteToFile
    
    jc  errorEscritura          ; JC salta si hay acarreo/error de escritura
    cmp eax, SIZEOF texto - 1
    jne errorEscritura          ; Si no escribió todos los bytes, hubo un error de escritura parcial

    ; --- 3. CERRAR EL ARCHIVO ---
    mov eax, archivoHandle
    call CloseFile
    test eax, eax
    je  Error                   ; Si CloseFile devuelve 0, ocurrió un error al cerrar

    ; --- 4. MENSAJE DE ÉXITO ---
    mov edx, OFFSET mensajeExito
    call WriteString
    jmp fin

errorEscritura:
    ; Si falló la escritura, primero cerramos el archivo para liberar memoria
    mov eax, archivoHandle
    call CloseFile              

Error:
    ; Bloque común para mostrar el mensaje de error
    mov edx, OFFSET mensajeError
    call WriteString

fin:
    exit
main ENDP

END main
