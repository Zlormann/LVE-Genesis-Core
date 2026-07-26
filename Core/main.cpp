#include <iostream>

#include "Engine/LVEEngine.h"
#include "World/WorldGenerator.h"
#include "ProceduralGenerator/Generator.h"
#include "Entities/Entity.h"
#include "SaveSystem/SaveManager.h"
#include "Player/Questionnaire.h"
#include "AI/PersonalityAnalyzer.h"


int main()
{
    std::cout << "====================================\n";
    std::cout << "      LVE Genesis Core v0.02\n";
    std::cout << "      LibreVerse Engine\n";
    std::cout << "====================================\n\n";


    LVEEngine engine;
    engine.Initialize();


    Questionnaire questionnaire;

    PlayerProfile profile =
        questionnaire.CreateProfile();

    profile.Display();

    PersonalityAnalyzer analyzer;

    analyzer.Analyze(profile);

    int customSeed =
        profile.GenerateSeed();

    std::cout << "\n[WORLD] Custom Seed : "
              << customSeed << "\n";


    WorldGenerator worldSystem;
    worldSystem.Initialize();


    Generator generator;

    WorldData world = generator.Generate(84739201);

    world.Display();


    Entity playerEntity;
    playerEntity.Create("LibreVerse_Player");


    SaveManager save;
    save.Initialize();


    std::cout << "\nLibreVerse Engine Online\n";

    return 0;
}
