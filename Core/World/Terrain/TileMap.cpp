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
