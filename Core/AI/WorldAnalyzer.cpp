#include <iostream>

#include "WorldAnalyzer.h"


WorldSettings WorldAnalyzer::Analyze(PlayerProfile profile)
{

    WorldSettings settings;


    settings.forestDensity = 50;
    settings.cityDensity = 50;
    settings.dangerLevel = 50;
    settings.rareCreatureRate = 50;
    settings.technologyLevel = 50;


    if(profile.nature > 7)
    {
        settings.forestDensity = 90;
        settings.rareCreatureRate = 80;
        settings.cityDensity = 20;
    }


    if(profile.combat > 7)
    {
        settings.dangerLevel = 90;
    }


    if(profile.construction > 7)
    {
        settings.cityDensity = 80;
        settings.technologyLevel = 70;
    }


    std::cout << "\n[AI] World analysis completed\n";


    return settings;
}
