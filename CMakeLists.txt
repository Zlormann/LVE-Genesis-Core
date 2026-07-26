cmake_minimum_required(VERSION 3.20)

project(LVE_Genesis_Core)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lstdc++fs")

include_directories(Core)

add_executable(
    lve_engine

    Core/main.cpp

    Core/Engine/LVEEngine.cpp

    Core/World/WorldGenerator.cpp
    Core/World/WorldData.cpp

    Core/ProceduralGenerator/Generator.cpp

    Core/ProceduralGenerator/TerrainGenerator.cpp

    Core/World/Terrain/TerrainMap.cpp

    Core/Entities/Entity.cpp

    Core/SaveSystem/SaveManager.cpp

    Core/SaveSystem/UniverseSaver.cpp

    Core/SaveSystem/UniverseLoader.cpp

    Core/ECS/EntityManager.cpp

    Core/Systems/MovementSystem.cpp

    Core/Systems/AISystem.cpp

    Core/World/UniverseManager.cpp

    Core/Player/PlayerProfile.cpp
    Core/Player/Questionnaire.cpp

    Core/AI/PersonalityAnalyzer.cpp

    Core/AI/WorldAnalyzer.cpp

    Core/World/WorldSettings.cpp
)
