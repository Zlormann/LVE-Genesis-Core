#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.12"
echo " Procedural Terrain Renderer"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/6] Création système Terrain..."

mkdir -p Core/World/Terrain
mkdir -p Core/Rendering



cat > Core/World/Terrain/Tile.h <<'EOF'
#ifndef TILE_H
#define TILE_H


enum class TileType
{
    GRASS,
    WATER,
    ROCK,
    SAND
};


struct Tile
{

    TileType type;


    Tile()
    {
        type = TileType::GRASS;
    }

};


#endif
EOF



cat > Core/World/Terrain/TileMap.h <<'EOF'
#ifndef TILEMAP_H
#define TILEMAP_H


#include <vector>
#include "Tile.h"


class TileMap
{

public:

    int width;
    int height;


    std::vector<Tile> tiles;


    void Generate(unsigned int seed);

    Tile& Get(int x,int y);

};


#endif
EOF



cat > Core/World/Terrain/TileMap.cpp <<'EOF'
#include "TileMap.h"
#include <cstdlib>
#include <iostream>


void TileMap::Generate(unsigned int seed)
{

    srand(seed);


    width=20;
    height=12;


    tiles.resize(width*height);


    for(auto &tile : tiles)
    {

        int value=rand()%4;


        tile.type =
        static_cast<TileType>(value);

    }


    std::cout
    << "[OK] Terrain Generated Seed : "
    << seed
    << "\n";

}



Tile& TileMap::Get(int x,int y)
{

    return tiles[y*width+x];

}
EOF



echo "[2/6] Création Terrain Renderer..."



cat > Core/Rendering/TerrainRenderer2D.h <<'EOF'
#ifndef TERRAIN_RENDERER_2D_H
#define TERRAIN_RENDERER_2D_H


class TerrainRenderer2D
{

public:

    void Render();

};


#endif
EOF



cat > Core/Rendering/TerrainRenderer2D.cpp <<'EOF'
#include "TerrainRenderer2D.h"
#include <iostream>


void TerrainRenderer2D::Render()
{

    std::cout
    << "[OK] Terrain Renderer 2D\n";

}

EOF



echo "[3/6] Mise à jour CMake..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


files=[
"Core/World/Terrain/TileMap.cpp",
"Core/Rendering/TerrainRenderer2D.cpp"
]


for f in files:

    if f not in s:

        s=s.replace(
        "Core/Rendering/Renderer2D.cpp",
        "Core/Rendering/Renderer2D.cpp\n    "+f
        )


open(p,"w").write(s)

EOF



echo "[4/6] Documentation..."

cat > Docs/TerrainRenderer.md <<'EOF'
# LVE Terrain Renderer v0.12


Pipeline :

World Generator

↓

TileMap

↓

Terrain Renderer 2D

↓

SDL2


Types :

- Grass
- Water
- Rock
- Sand
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
echo " Terrain Renderer v0.12 OK"
echo " LibreVerse World Ready"
echo "===================================="

else

echo "Erreur compilation"

fi
