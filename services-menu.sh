#!/bin/bash

# Función para listar el contenido de un archivo
listar_contenido() {
    local archivo="$1"
    if [ -f "$archivo" ]; then
        cat "$archivo"
    else
        echo "El archivo '$archivo' no existe o no es un archivo regular."
    fi
}

# Función para crear un archivo de texto
crear_archivo() {
    local texto="$1"
    local archivo
    read -p "Ingrese el nombre del archivo a crear: " archivo
    echo "$texto" > "$archivo"
    echo "Archivo '$archivo' creado exitosamente."
}

# Función para comparar dos archivos
comparar_archivos() {
    local archivo1="$1"
    local archivo2="$2"
    if [ -f "$archivo1" ] && [ -f "$archivo2" ]; then
        if cmp -s "$archivo1" "$archivo2"; then
            echo "Los archivos '$archivo1' y '$archivo2' son idénticos."
        else
            echo "Los archivos '$archivo1' y '$archivo2' son diferentes."
        fi
    else
        echo "Uno o ambos archivos no existen o no son archivos regulares."
    fi
}

# Función para ejecutar comandos awk sobre un archivo
ejecutar_awk() {
    local archivo="$1"
    read -p "Ingrese el patrón awk (ej: '{print $1}'): " patron_awk
    awk "$patron_awk" "$archivo"
}

# Función para ejecutar comandos grep sobre un archivo
ejecutar_grep() {
    local archivo="$1"
    read -p "Ingrese el patrón grep: " patron_grep
    grep "$patron_grep" "$archivo"
}

while true; do
    clear
    echo "Menú de opciones:"
    echo "1. Listar el contenido de un archivo"
    echo "2. Crear un archivo de texto"
    echo "3. Comparar dos archivos"
    echo "4. Ejecutar awk sobre un archivo"
    echo "5. Ejecutar grep sobre un archivo"
    echo "0. Salir"
    read -p "Ingrese una opción: " opcion

    case $opcion in
        1)
            read -p "Ingrese la ruta absoluta del archivo: " archivo
            listar_contenido "$archivo"
            ;;
        2)
            read -p "Ingrese el texto a almacenar: " texto
            crear_archivo "$texto"
            ;;
        3)
            read -p "Ingrese la ruta del primer archivo: " archivo1
            read -p "Ingrese la ruta del segundo archivo: " archivo2
            comparar_archivos "$archivo1" "$archivo2"
            ;;
        4)
            read -p "Ingrese la ruta del archivo: " archivo
            ejecutar_awk "$archivo"
            ;;
        5)
            read -p "Ingrese la ruta del archivo: " archivo
            ejecutar_grep "$archivo"
            ;;
        0)
            break
            ;;
        *)
            echo "Opción inválida"
            ;;
    esac

    read -p "Presione Enter para continuar..."
done
