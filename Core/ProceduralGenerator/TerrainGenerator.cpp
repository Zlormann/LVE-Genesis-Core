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
