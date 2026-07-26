#include <iostream>
#include <fstream>
#include <filesystem>

#include "UniverseSaver.h"


void UniverseSaver::SaveProfile(PlayerProfile profile)
{

    std::filesystem::create_directories(
        "Worlds/Players/" + profile.name
    );


    std::ofstream file(
        "Worlds/Players/" + profile.name + "/profile.lve"
    );


    file << "PLAYER=" << profile.name << "\n";
    file << "EXPLORATION=" << profile.exploration << "\n";
    file << "NATURE=" << profile.nature << "\n";
    file << "COMBAT=" << profile.combat << "\n";
    file << "CONSTRUCTION=" << profile.construction << "\n";


    file.close();


    std::cout << "[SAVE] Profile saved\n";
}



void UniverseSaver::SaveWorldSeed(int seed)
{

    std::ofstream file(
        "Worlds/Players/world.seed"
    );


    file << seed;


    file.close();


    std::cout << "[SAVE] World seed saved\n";

}



void UniverseSaver::SaveTerrain(TerrainMap terrain)
{

    std::ofstream file(
        "Worlds/Players/terrain.data"
    );


    file << "TERRAIN GENERATED";


    file.close();


    std::cout << "[SAVE] Terrain saved\n";

}
