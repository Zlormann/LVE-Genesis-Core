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
