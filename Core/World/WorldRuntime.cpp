#include "WorldRuntime.h"

#include <iostream>



WorldRuntime::WorldRuntime()
{

    seed=0;
    worldTime=0;

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

    worldTime++;

    if(worldTime % 60 == 0)
    {
        std::cout
        << "[WORLD] Runtime Tick : "
        << worldTime
        << "\n";
    }

    // Future :
    // météo
    // cycle jour/nuit
    // simulation monde


}



TileMap& WorldRuntime::GetTerrain()
{

    return terrain;

}
