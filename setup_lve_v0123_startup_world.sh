#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.12.3"
echo " World Runtime Startup Integration"
echo " LibreVerse Engine"
echo "===================================="

cd ~/LVE-Genesis-Core || exit


echo "[1/5] Connexion WorldRuntime au moteur..."


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


if '#include "World/WorldRuntime.h"' not in s:
    s=s.replace(
        '#include "Engine/LVEEngine.h"',
        '#include "Engine/LVEEngine.h"\n#include "World/WorldRuntime.h"'
    )


if 'WorldRuntime world;' not in s:

    s=s.replace(
        'std::cout << "LibreVerse Engine Online" << std::endl;',
        '''
WorldRuntime world;

world.Initialize(84739201);

std::cout << "[OK] World Runtime Startup" << std::endl;

std::cout << "LibreVerse World Online" << std::endl;
'''
    )


open(p,"w").write(s)

EOF


echo "[2/5] Mise à jour version moteur..."


echo "[3/5] Nettoyage Build..."

rm -rf Build
mkdir Build


echo "[4/5] Compilation..."

cd Build || exit

cmake ..

if make
then

echo ""
echo "===================================="
echo " World Runtime Startup OK"
echo " LVE v0.12.3 installé"
echo "===================================="

else

echo "Erreur compilation"

fi
