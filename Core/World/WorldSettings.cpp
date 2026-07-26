#include <iostream>
#include "WorldSettings.h"


void WorldSettings::Display()
{
    std::cout << "\n=== WORLD SETTINGS ===\n";

    std::cout << "Forets : "
              << forestDensity << "%\n";

    std::cout << "Villes : "
              << cityDensity << "%\n";

    std::cout << "Danger : "
              << dangerLevel << "%\n";

    std::cout << "Creatures rares : "
              << rareCreatureRate << "%\n";

    std::cout << "Technologie : "
              << technologyLevel << "%\n";
}
