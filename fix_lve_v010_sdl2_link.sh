#!/bin/bash

echo "===================================="
echo " LVE v0.10 SDL2 Link Fix"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/4] Correction CMake SDL2..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


# Ajouter SDL2 après project si absent
if "find_package(SDL2" not in s:

    s=s.replace(
        "project",
        "find_package(SDL2 REQUIRED)\n\nproject"
    )


# Ajouter le linkage SDL2 à la fin
if "SDL2::SDL2" not in s:

    s += """

find_package(SDL2 REQUIRED)

target_link_libraries(
    lve_engine
    SDL2::SDL2
)

"""


open(p,"w").write(s)

EOF



echo "[2/4] Nettoyage Build..."

rm -rf Build

mkdir Build


echo "[3/4] Recompilation..."


cd Build || exit


cmake ..

if make
then

echo ""
echo "===================================="
echo " Compilation réussie"
echo " LVE Renderer SDL2 opérationnel"
echo "===================================="

else

echo "Erreur compilation"

fi
