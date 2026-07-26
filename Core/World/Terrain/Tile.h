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
