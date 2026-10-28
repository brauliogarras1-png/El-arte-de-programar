#!/usr/bin/env bash
 
set -euo pipefail
 
DIRECTORIO="${1:-.}"
PALABRA="${2:-home}"
 
if [[ ! -d "$DIRECTORIO" ]]; then
    echo "Error: '$DIRECTORIO' no es un directorio válido." >&2
    exit 1
fi
 
encontrados=0
 
while IFS= read -r -d '' archivo; do
    if grep -qiw -- "$PALABRA" "$archivo"; then
        echo "$archivo"
        encontrados=$((encontrados + 1))
    fi
done < <(find "$DIRECTORIO" -type d -name .git -prune -o -type f -name "*.txt" -print0)
 
echo "---"
echo "Archivos .txt que contienen \"$PALABRA\": $encontrados"
 
[[ $encontrados -gt 0 ]]

