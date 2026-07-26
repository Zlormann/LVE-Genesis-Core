#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.12.1"
echo " Real Terrain Rendering SDL2"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/6] Mise à jour Terrain Renderer..."

mkdir -p Core/Rendering



cat > Core/Rendering/TerrainRenderer2D.h <<'EOF'
#ifndef TERRAIN_RENDERER_2D_H
#define TERRAIN_RENDERER_2D_H

#include <SDL2/SDL.h>
#include "../World/Terrain/TileMap.h"


class TerrainRenderer2D
{

private:

    SDL_Renderer* renderer;

    int tileSize;


public:

    TerrainRenderer2D();


    void Initialize(SDL_Renderer* r);


    void Render(TileMap& map);


};


#endif
EOF



cat > Core/Rendering/TerrainRenderer2D.cpp <<'EOF'
#include "TerrainRenderer2D.h"


TerrainRenderer2D::TerrainRenderer2D()
{

    renderer=nullptr;

    tileSize=32;

}



void TerrainRenderer2D::Initialize(SDL_Renderer* r)
{

    renderer=r;

}



void TerrainRenderer2D::Render(TileMap& map)
{


    if(!renderer)
        return;



    for(int y=0;y<map.height;y++)
    {

        for(int x=0;x<map.width;x++)
        {


            SDL_Rect rect;


            rect.x=x*tileSize;
            rect.y=y*tileSize;

            rect.w=tileSize;
            rect.h=tileSize;



            switch(map.Get(x,y).type)
            {


                case TileType::GRASS:

                    SDL_SetRenderDrawColor(
                        renderer,
                        40,180,40,255);

                    break;


                case TileType::WATER:

                    SDL_SetRenderDrawColor(
                        renderer,
                        40,80,220,255);

                    break;


                case TileType::ROCK:

                    SDL_SetRenderDrawColor(
                        renderer,
                        120,120,120,255);

                    break;


                case TileType::SAND:

                    SDL_SetRenderDrawColor(
                        renderer,
                        220,200,120,255);

                    break;

            }


            SDL_RenderFillRect(
                renderer,
                &rect);

        }

    }


}
EOF



echo "[2/6] Ajout génération terrain..."

cat > Docs/RealTerrainRenderer.md <<'EOF'
# LVE Real Terrain Renderer v0.12.1


Pipeline :

World Generator

↓

TileMap

↓

TerrainRenderer2D

↓

SDL2


Tiles :

- Grass
- Water
- Rock
- Sand
EOF



echo "[3/6] Vérification CMake..."

grep -q "TerrainRenderer2D.cpp" CMakeLists.txt

if [ $? -ne 0 ]
then

echo "TerrainRenderer2D.cpp absent de CMake"

sed -i '/Core\/Rendering\/Renderer2D.cpp/a\    Core/Rendering/TerrainRenderer2D.cpp' CMakeLists.txt

fi



echo "[4/6] Nettoyage Build..."

rm -rf Build

mkdir Build



echo "[5/6] Compilation..."

cd Build || exit

cmake ..



echo "[6/6] Build..."

if make
then

echo ""
echo "===================================="
echo " Real Terrain Renderer SDL2 OK"
echo " LVE v0.12.1 installé"
echo "===================================="

else

echo "Erreur compilation"

fi
