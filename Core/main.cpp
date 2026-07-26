#include "Engine/LVEVersion.h"

#include <iostream>

#include "Engine/LVEEngine.h"
#include "Engine/GameLoop.h"
#include "World/WorldRuntime.h"
#include "World/WorldGenerator.h"
#include "ProceduralGenerator/Generator.h"
#include "Entities/Entity.h"
#include "SaveSystem/SaveManager.h"
#include "ECS/EntityManager.h"
#include "Systems/MovementSystem.h"
#include "Systems/AISystem.h"
#include "SaveSystem/UniverseSaver.h"
#include "Player/Questionnaire.h"
#include "AI/PersonalityAnalyzer.h"
#include "AI/WorldAnalyzer.h"
#include "World/WorldSettings.h"
#include "ProceduralGenerator/TerrainGenerator.h"


int main()
{
    GameLoop gameLoop;

    std::cout << "====================================\n";
    std::cout << "      LVE Genesis Core v0.12.3\n";
    std::cout << "      LibreVerse Engine\n";
    std::cout << "====================================\n\n";


    LVEEngine engine;
    engine.Initialize();


    WorldRuntime runtime;

    runtime.Initialize(84739201);

    gameLoop.SetWorld(&runtime);

    std::cout << "[OK] GameLoop connected to WorldRuntime\n";

    gameLoop.Start();


    std::cout << "[OK] GameLoop connected to WorldRuntime\n";



    std::cout << "[OK] World Runtime Startup\n";



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


    WorldAnalyzer worldAI;

    WorldSettings settings =
        worldAI.Analyze(profile);

    settings.Display();


    TerrainGenerator terrainGenerator;

    TerrainMap terrain =
        terrainGenerator.CreateTerrain();

    terrain.Display();


    WorldGenerator worldSystem;
    worldSystem.Initialize();


    Generator generator;

    WorldData world = generator.Generate(84739201);

    world.Display();

    Entity playerEntity;
    playerEntity.Create("LibreVerse_Player");


    UniverseSaver universeSaver;

    universeSaver.SaveProfile(profile);

    universeSaver.SaveWorldSeed(customSeed);

    universeSaver.SaveTerrain(terrain);


    EntityManager entityManager;

    entityManager.CreateEntity("LibreVerse_Player");
    entityManager.CreateEntity("Wolf");
    entityManager.CreateEntity("Ancient_Tree");
    entityManager.CreateEntity("Village");


    entityManager.DisplayEntities();


    MovementSystem movement;
    AISystem ai;

    movement.Update();
    ai.Update();


    SaveManager save;

    save.Initialize();


    std::cout << "\nLibreVerse Engine Online\n";

    


    return 0;
}
