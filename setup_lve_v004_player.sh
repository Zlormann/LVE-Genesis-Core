#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.04"
echo " Player Profile System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création du système joueur..."

mkdir -p Core/Player Core/AI Core/World/Players


cat > Core/Player/PlayerProfile.h <<'EOF'
#ifndef PLAYER_PROFILE_H
#define PLAYER_PROFILE_H

#include <string>

class PlayerProfile
{

public:

    std::string name;

    int exploration;
    int construction;
    int combat;
    int nature;
    int social;

    int GenerateSeed();

    void Display();

};

#endif
EOF


cat > Core/Player/PlayerProfile.cpp <<'EOF'
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
EOF



echo "[2/6] Création questionnaire..."


cat > Core/Player/Questionnaire.h <<'EOF'
#ifndef QUESTIONNAIRE_H
#define QUESTIONNAIRE_H

#include "PlayerProfile.h"

class Questionnaire
{

public:

    PlayerProfile CreateProfile();

};

#endif
EOF



cat > Core/Player/Questionnaire.cpp <<'EOF'
#include <iostream>
#include "Questionnaire.h"


PlayerProfile Questionnaire::CreateProfile()
{

    PlayerProfile player;


    std::cout << "\nBienvenue dans LibreVerse\n\n";

    std::cout << "Votre nom : ";
    std::cin >> player.name;


    std::cout << "\nVotre style ?\n";
    std::cout << "1 - Exploration\n";
    std::cout << "2 - Construction\n";
    std::cout << "3 - Combat\n";

    int choix;

    std::cout << "Choix : ";
    std::cin >> choix;


    player.exploration = 5;
    player.construction = 5;
    player.combat = 5;
    player.nature = 5;
    player.social = 5;


    if(choix == 1)
    {
        player.exploration = 10;
        player.nature = 9;
    }


    if(choix == 2)
    {
        player.construction = 10;
        player.social = 8;
    }


    if(choix == 3)
    {
        player.combat = 10;
    }


    return player;

}
EOF



echo "[3/6] Création analyse IA..."

mkdir -p Core/AI


cat > Core/AI/PersonalityAnalyzer.h <<'EOF'
#ifndef PERSONALITY_ANALYZER_H
#define PERSONALITY_ANALYZER_H

#include "../Player/PlayerProfile.h"

class PersonalityAnalyzer
{

public:

    void Analyze(PlayerProfile profile);

};

#endif
EOF



cat > Core/AI/PersonalityAnalyzer.cpp <<'EOF'
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
EOF



echo "[4/6] Connexion au moteur..."


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()

s=s.replace(
'#include "SaveSystem/SaveManager.h"',
'#include "SaveSystem/SaveManager.h"\n#include "Player/Questionnaire.h"\n#include "AI/PersonalityAnalyzer.h"'
)


s=s.replace(
'WorldGenerator worldSystem;',
'''Questionnaire questionnaire;

    PlayerProfile player =
        questionnaire.CreateProfile();

    player.Display();

    PersonalityAnalyzer analyzer;

    analyzer.Analyze(player);

    int customSeed =
        player.GenerateSeed();

    std::cout << "\\n[WORLD] Custom Seed : "
              << customSeed << "\\n";


    WorldGenerator worldSystem;'''
)


open(p,"w").write(s)

EOF



echo "[5/6] Mise à jour CMake..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/SaveSystem/SaveManager.cpp",
"""Core/SaveSystem/SaveManager.cpp

    Core/Player/PlayerProfile.cpp
    Core/Player/Questionnaire.cpp

    Core/AI/PersonalityAnalyzer.cpp"""
)


open(p,"w").write(s)

EOF



echo "[6/6] Compilation..."


mkdir -p Build

cd Build || exit


cmake ..

if make
then

echo ""
echo "Compilation OK"
echo ""

./lve_engine

else

echo "Erreur compilation"

fi
