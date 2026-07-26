#!/bin/bash

echo "===================================="
echo " LVE v0.10 SDL2 CMake Repair"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/4] Correction CMakeLists.txt..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


# Supprime les anciens essais SDL2
s=s.replace("find_package(SDL2 REQUIRED)\n\n","")
s=s.replace("find_package(SDL2 REQUIRED)","")


# Ajout configuration SDL2 compatible Linux
if "sdl2-config" not in s:

    s += """



# SDL2 Linux configuration

execute_process(
    COMMAND sdl2-config --cflags
    OUTPUT_VARIABLE SDL2_CFLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND sdl2-config --libs
    OUTPUT_VARIABLE SDL2_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

target_compile_options(
    lve_engine PRIVATE
    ${SDL2_CFLAGS}
)

target_link_libraries(
    lve_engine
    ${SDL2_LIBS}
)

"""



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
echo " SDL2 LINK OK"
echo " LVE Renderer prêt"
echo "===================================="

else

echo "Erreur compilation"

fi
