#!/bin/bash

echo "===================================="
echo " LVE v0.10 SDL2 Final Fix"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/4] Suppression ancien SDL2::SDL2..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


# Suppression ancien linkage CMake SDL2
s=s.replace(
"""
target_link_libraries(
    lve_engine
    SDL2::SDL2
)
""",
""
)


open(p,"w").write(s)

EOF



echo "[2/4] Nettoyage Build..."

rm -rf Build

mkdir Build


echo "[3/4] Compilation..."

cd Build || exit

cmake ..


if make
then

echo ""
echo "===================================="
echo " Compilation SDL2 réussie"
echo " LVE Renderer v0.10 OK"
echo "===================================="

else

echo "Erreur compilation"

fi
