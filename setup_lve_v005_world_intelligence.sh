#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.05"
echo " World Intelligence System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création du système World Intelligence..."


mkdir -p Core/World Core/AI


cat > Core/World/WorldSettings.h <<'EOF'
#ifndef WORLD_SETTINGS_H
#define WORLD_SETTINGS_H

class WorldSettings
{

public:

    int forestDensity;
    int cityDensity;
    int dangerLevel;
    int rareCreatureRate;
    int technologyLevel;

    void Display();

};

#endif
EOF



cat > Core/World/WorldSettings.cpp <<'EOF'
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
EOF



echo "[2/6] Création analyseur monde..."


cat > Core/AI/WorldAnalyzer.h <<'EOF'
#ifndef WORLD_ANALYZER_H
#define WORLD_ANALYZER_H

#include "../Player/PlayerProfile.h"
#include "../World/WorldSettings.h"


class WorldAnalyzer
{

public:

    WorldSettings Analyze(PlayerProfile profile);

};

#endif
EOF



cat > Core/AI/WorldAnalyzer.cpp <<'EOF'
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
EOF



echo "[3/6] Connexion au moteur..."


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


s=s.replace(
'#include "AI/PersonalityAnalyzer.h"',
'#include "AI/PersonalityAnalyzer.h"\n#include "AI/WorldAnalyzer.h"\n#include "World/WorldSettings.h"'
)


s=s.replace(
'WorldGenerator worldSystem;',
'''WorldAnalyzer worldAI;

    WorldSettings settings =
        worldAI.Analyze(profile);

    settings.Display();


    WorldGenerator worldSystem;'''
)


open(p,"w").write(s)

EOF



echo "[4/6] Mise à jour CMake..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/AI/PersonalityAnalyzer.cpp",
"""Core/AI/PersonalityAnalyzer.cpp

    Core/AI/WorldAnalyzer.cpp

    Core/World/WorldSettings.cpp"""
)


open(p,"w").write(s)

EOF



echo "[5/6] Compilation..."


mkdir -p Build

cd Build || exit

cmake ..


if make
then

echo ""
echo "Compilation OK"
echo ""

echo "Démarrage LibreVerse..."

./lve_engine

else

echo "Erreur compilation"

fi
