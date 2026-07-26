#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.10.2.1"
echo " Version Identity System"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/4] Création système version..."


mkdir -p Core/Engine


cat > Core/Engine/LVEVersion.h <<'EOF'
#ifndef LVE_VERSION_H
#define LVE_VERSION_H


#define LVE_ENGINE_NAME "LibreVerse Engine"
#define LVE_CORE_NAME "Genesis Core"

#define LVE_VERSION_MAJOR 0
#define LVE_VERSION_MINOR 10
#define LVE_VERSION_PATCH 2


#define LVE_VERSION_STRING "0.10.2"


#endif
EOF



echo "[2/4] Mise à jour affichage moteur..."


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


if '#include "Engine/LVEVersion.h"' not in s:

    s=s.replace(
        '#include',
        '#include "Engine/LVEVersion.h"\n\n#include',
        1
    )


s=s.replace(
'LVE Genesis Core v0.02',
'LVE Genesis Core v0.10.2'
)


open(p,"w").write(s)

EOF



echo "[3/4] Nettoyage Build..."

rm -rf Build

mkdir Build


echo "[4/4] Compilation..."

cd Build || exit

cmake ..

if make
then

echo ""
echo "===================================="
echo " Version Identity installée"
echo " Compilation OK"
echo "===================================="

else

echo "Erreur compilation"

fi
