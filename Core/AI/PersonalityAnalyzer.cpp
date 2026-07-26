#include <iostream>
#include "PersonalityAnalyzer.h"


void PersonalityAnalyzer::Analyze(PlayerProfile profile)
{

    std::cout << "\n[AI] Analyse du profil...\n";


    if(profile.nature > 7)
        std::cout << "[AI] Monde naturel favorisé\n";


    if(profile.construction > 7)
        std::cout << "[AI] Civilisations augmentées\n";


    if(profile.combat > 7)
        std::cout << "[AI] Niveau de danger augmenté\n";

}
