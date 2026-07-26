#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.03"
echo " Procedural World Generator"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/5] Création du World Generator avancé..."


mkdir -p Core/World Core/ProceduralGenerator Worlds/Generated


cat > Core/World/WorldData.h <<'EOF'
#ifndef WORLD_DATA_H
#define WORLD_DATA_H

#include <string>

class WorldData
{
public:

    int seed;
    std::string biome;

    void Display();

};

#endif
EOF


cat > Core/World/WorldData.cpp <<'EOF'
#include <iostream>
#include "WorldData.h"


void WorldData::Display()
{
    std::cout << "[WORLD] Seed : "
              << seed << std::endl;

    std::cout << "[WORLD] Biome : "
              << biome << std::endl;
}
EOF



cat > Core/ProceduralGenerator/Generator.h <<'EOF'
#ifndef GENERATOR_H
#define GENERATOR_H

#include "../World/WorldData.h"


class Generator
{

public:

    WorldData Generate(int seed);

};


#endif
EOF



cat > Core/ProceduralGenerator/Generator.cpp <<'EOF'
#include <iostream>
#include "Generator.h"


WorldData Generator::Generate(int seed)
{

    WorldData world;

    world.seed = seed;


    if(seed % 3 == 0)
        world.biome = "Forest";

    else if(seed % 3 == 1)
        world.biome = "Mountain";

    else
        world.biome = "Ocean";


    std::cout << "[OK] Terrain generated\n";
    std::cout << "[OK] Biome generated\n";


    return world;
}
EOF



echo "[2/5] Mise à jour du moteur..."


python3 <<'EOF'
p="Core/main.cpp"

s=open(p).read()

s=s.replace(
'Generator generator;\n    generator.Initialize();',
'''Generator generator;

    WorldData world = generator.Generate(84739201);

    world.Display();'''
)

open(p,"w").write(s)
EOF



echo "[3/5] Mise à jour CMake..."


python3 <<'EOF'
p="CMakeLists.txt"

s=open(p).read()

s=s.replace(
"Core/World/WorldGenerator.cpp",
"Core/World/WorldGenerator.cpp\n    Core/World/WorldData.cpp"
)

open(p,"w").write(s)
EOF



echo "[4/5] Compilation..."


mkdir -p Build

cd Build || exit

cmake ..

make



echo "[5/5] Lancement du monde procédural..."


./lve_engine
