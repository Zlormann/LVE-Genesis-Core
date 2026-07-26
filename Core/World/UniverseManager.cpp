#include <iostream>
#include <ctime>

#include "UniverseManager.h"


std::string UniverseManager::CreateUniverseID(
std::string playerName)
{

    std::string id =
    "LV-" +
    playerName +
    "-" +
    std::to_string(time(nullptr));


    std::cout
    << "[SYSTEM] Universe ID : "
    << id
    << "\n";


    return id;

}
