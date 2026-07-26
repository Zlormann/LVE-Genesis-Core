#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.06"
echo " Procedural Terrain Engine"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création du système terrain..."


mkdir -p Core/World/Terrain
mkdir -p Core/World/Biomes


cat > Core/World/Terrain/TerrainMap.h <<'EOF'
#ifndef TERRAIN_MAP_H
#define TERRAIN_MAP_H

#include <vector>

class TerrainMap
{

private:

    int width;
    int height;

    std::vector<std::vector<char>> tiles;


public:

    TerrainMap(int w, int h);

    void Generate();

    void Display();

};

#endif
EOF



cat > Core/World/Terrain/TerrainMap.cpp <<'EOF'
#include <iostream>
#include <cstdlib>

#include "TerrainMap.h"


TerrainMap::TerrainMap(int w, int h)
{
    width = w;
    height = h;

    tiles.resize(height,
        std::vector<char>(width,'.'));
}



void TerrainMap::Generate()
{

    for(int y=0;y<height;y++)
    {
        for(int x=0;x<width;x++)
        {

            int value = rand()%100;


            if(value < 15)
                tiles[y][x]='~';

            else if(value < 35)
                tiles[y][x]='M';

            else if(value < 70)
                tiles[y][x]='F';

            else
                tiles[y][x]='.';

        }
    }

}



void TerrainMap::Display()
{

    std::cout << "\n=== LibreVerse Terrain ===\n\n";


    for(auto row : tiles)
    {

        for(char tile : row)
            std::cout << tile;

        std::cout << "\n";

    }


    std::cout << "\n";
}
EOF



echo "[2/6] Création Terrain Generator..."


cat > Core/ProceduralGenerator/TerrainGenerator.h <<'EOF'
#ifndef TERRAIN_GENERATOR_H
#define TERRAIN_GENERATOR_H

#include "../World/Terrain/TerrainMap.h"


class TerrainGenerator
{

public:

    TerrainMap CreateTerrain();

};


#endif
EOF



cat > Core/ProceduralGenerator/TerrainGenerator.cpp <<'EOF'
#include <iostream>

#include "TerrainGenerator.h"


TerrainMap TerrainGenerator::CreateTerrain()
{

    std::cout << "[WORLD] Generating terrain...\n";


    TerrainMap map(20,10);


    map.Generate();


    std::cout << "[OK] Terrain generated\n";


    return map;

}
EOF



echo "[3/6] Connexion au moteur..."


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


s=s.replace(
'#include "World/WorldSettings.h"',
'#include "World/WorldSettings.h"\n#include "ProceduralGenerator/TerrainGenerator.h"'
)


s=s.replace(
'WorldGenerator worldSystem;',
'''TerrainGenerator terrainGenerator;

    TerrainMap terrain =
        terrainGenerator.CreateTerrain();

    terrain.Display();


    WorldGenerator worldSystem;'''
)


open(p,"w").write(s)

EOF



echo "[4/6] Mise à jour CMake..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/ProceduralGenerator/Generator.cpp",
"""Core/ProceduralGenerator/Generator.cpp

    Core/ProceduralGenerator/TerrainGenerator.cpp

    Core/World/Terrain/TerrainMap.cpp"""
)


open(p,"w").write(s)

EOF



echo "[5/6] Compilation..."


mkdir -p Build

cd Build || exit

cmake ..


if make
then

echo ""
echo "Compilation OK"
echo ""

./lve_engine

else

echo "Erreur compilation"

fi
