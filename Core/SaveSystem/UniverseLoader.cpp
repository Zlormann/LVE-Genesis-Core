#include <iostream>
#include <fstream>
#include <filesystem>

#include "UniverseLoader.h"


bool UniverseLoader::LoadUniverse(std::string playerName)
{

    std::string path =
    "Worlds/Players/" + playerName;


    if(!std::filesystem::exists(path))
    {
        std::cout << "[LOAD] Aucun univers trouvé\n";
        return false;
    }


    std::cout << "[LOAD] Univers trouvé\n";


    DisplayUniverseInfo(playerName);


    return true;
}



void UniverseLoader::DisplayUniverseInfo(std::string playerName)
{

    std::ifstream file(
        "Worlds/Players/" +
        playerName +
        "/profile.lve"
    );


    std::cout << "\n=== UNIVERS LOADED ===\n";


    std::string line;


    while(getline(file,line))
    {
        std::cout << line << "\n";
    }


    file.close();

}
