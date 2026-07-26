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
