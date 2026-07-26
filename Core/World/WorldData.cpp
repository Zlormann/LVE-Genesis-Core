#include <iostream>
#include "WorldData.h"


void WorldData::Display()
{
    std::cout << "[WORLD] Seed : "
              << seed << std::endl;

    std::cout << "[WORLD] Biome : "
              << biome << std::endl;
}
