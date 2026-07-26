#include <iostream>

#include "Engine/LVEEngine.h"
#include "World/WorldGenerator.h"
#include "ProceduralGenerator/Generator.h"
#include "Entities/Entity.h"
#include "SaveSystem/SaveManager.h"


int main()
{
    std::cout << "====================================\n";
    std::cout << "      LVE Genesis Core v0.02\n";
    std::cout << "      LibreVerse Engine\n";
    std::cout << "====================================\n\n";


    LVEEngine engine;
    engine.Initialize();


    WorldGenerator world;
    world.Initialize();


    Generator generator;
    generator.Initialize();


    Entity player;
    player.Create("LibreVerse_Player");


    SaveManager save;
    save.Initialize();


    std::cout << "\nLibreVerse Engine Online\n";

    return 0;
}
