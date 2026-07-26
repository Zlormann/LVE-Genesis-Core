#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.12.2"
echo " World Runtime Integration"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/6] Création World Runtime..."

mkdir -p Core/World



cat > Core/World/WorldRuntime.h <<'EOF'
#ifndef WORLD_RUNTIME_H
#define WORLD_RUNTIME_H


#include "Terrain/TileMap.h"


class WorldRuntime
{

private:

    TileMap terrain;

    unsigned int seed;


public:

    WorldRuntime();


    void Initialize(unsigned int worldSeed);


    void Update();


    TileMap& GetTerrain();


};


#endif
EOF



cat > Core/World/WorldRuntime.cpp <<'EOF'
#include "WorldRuntime.h"

#include <iostream>



WorldRuntime::WorldRuntime()
{

    seed=0;

}



void WorldRuntime::Initialize(unsigned int worldSeed)
{

    seed=worldSeed;


    std::cout
    << "[WORLD] Seed : "
    << seed
    << "\n";


    terrain.Generate(seed);


    std::cout
    << "[OK] World Runtime\n";

}



void WorldRuntime::Update()
{

    // Future :
    // météo
    // cycle jour/nuit
    // simulation monde


}



TileMap& WorldRuntime::GetTerrain()
{

    return terrain;

}
EOF



echo "[2/6] Connexion GameLoop..."

mkdir -p Core/Engine



cat > Core/Engine/WorldLoop.h <<'EOF'
#ifndef WORLD_LOOP_H
#define WORLD_LOOP_H


class WorldLoop
{

public:

    void UpdateWorld();

};


#endif
EOF



cat > Core/Engine/WorldLoop.cpp <<'EOF'
#include "WorldLoop.h"

#include <iostream>


void WorldLoop::UpdateWorld()
{

    std::cout
    << "[WORLD] Update\n";

}
EOF



echo "[3/6] Mise à jour CMake..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


files=[
"Core/World/WorldRuntime.cpp",
"Core/Engine/WorldLoop.cpp"
]


for f in files:

    if f not in s:

        s=s.replace(
        "Core/World/WorldGenerator.cpp",
        "Core/World/WorldGenerator.cpp\n    "+f
        )


open(p,"w").write(s)

EOF



echo "[4/6] Documentation..."

cat > Docs/WorldRuntime.md <<'EOF'
# LVE World Runtime v0.12.2


Le World Runtime contrôle :

- Seed monde
- Génération terrain
- Mise à jour monde


Pipeline :

GameLoop

↓

WorldRuntime

↓

TileMap

↓

Renderer SDL2
EOF



echo "[5/6] Nettoyage Build..."

rm -rf Build
mkdir Build



echo "[6/6] Compilation..."

cd Build || exit

cmake ..


if make
then

echo ""
echo "===================================="
echo " World Runtime Integration OK"
echo " LVE v0.12.2 installé"
echo "===================================="

else

echo "Erreur compilation"

fi
