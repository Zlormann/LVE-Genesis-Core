#ifndef WORLD_RUNTIME_H
#define WORLD_RUNTIME_H


#include "Terrain/TileMap.h"


class WorldRuntime
{

private:

    TileMap terrain;

    unsigned int seed;

    unsigned long long worldTime;


public:

    WorldRuntime();


    void Initialize(unsigned int worldSeed);


    void Update();


    TileMap& GetTerrain();


};


#endif
