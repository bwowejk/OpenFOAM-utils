#!/bin/bash

# ==============================
# Usage check
# ==============================
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 PATCH_NAME TIME OUTPUT.csv"
    echo "Example: $0 inlet1 0 inlet1_cells_0.csv"
    exit 1
fi

PATCH="$1"
TIME="$2"
OUT="$3"

echo "Patch  : $PATCH"
echo "Time   : $TIME"
echo "Output : $OUT"

# ==============================
# Write cell centres
# ==============================
echo "=== Writing cell centres ==="
postProcess -func writeCellCentres -time "$TIME" > log.writeCellCentres

CX="${TIME}/Cx"
CY="${TIME}/Cy"
CZ="${TIME}/Cz"

for f in "$CX" "$CY" "$CZ"; do
    if [ ! -f "$f" ]; then
        echo "ERROR: Missing file $f"
        exit 1
    fi
done

# ==============================
# Function to extract patch data
# ==============================
extract_patch () {
    local file="$1"
    awk "
    /^[[:space:]]*${PATCH}[[:space:]]*$/ {inPatch=1; next}
    inPatch && /^[[:space:]]*\\(/ {reading=1; next}
    reading && /^[[:space:]]*\\)/ {exit}
    reading && /^[[:space:]]*[0-9eE.+-]+/ {print \$1}
    " "$file"
}

# ==============================
# Combine Cx, Cy, Cz → CSV
# ==============================
{
    echo "x,y,z"
    paste -d',' \
        <(extract_patch "$CX") \
        <(extract_patch "$CY") \
        <(extract_patch "$CZ")
} > "$OUT"


echo "=== DONE ==="
echo "Saved: $OUT"
