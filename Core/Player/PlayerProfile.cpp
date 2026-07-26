#include <iostream>
#include <ctime>
#include "PlayerProfile.h"


int PlayerProfile::GenerateSeed()
{
    int seed =
        exploration * 10000 +
        nature * 1000 +
        social * 100 +
        combat * 10 +
        construction;

    return seed;
}


void PlayerProfile::Display()
{
    std::cout << "\n=== PLAYER PROFILE ===\n";

    std::cout << "Nom : "
              << name << "\n";

    std::cout << "Exploration : "
              << exploration << "\n";

    std::cout << "Nature : "
              << nature << "\n";

    std::cout << "Social : "
              << social << "\n";

    std::cout << "Combat : "
              << combat << "\n";

    std::cout << "Construction : "
              << construction << "\n";
}
