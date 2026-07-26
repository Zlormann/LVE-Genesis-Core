cmake_minimum_required(VERSION 3.20)

project(LVE_Genesis_Core)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -lstdc++fs")

include_directories(Core)

add_executable(
    lve_engine

    Core/main.cpp

    Core/Engine/LVEEngine.cpp
    Core/Physics/PhysicsWorld.cpp
    Core/Physics/Collider.cpp
    Core/Physics/GravitySystem.cpp
    Core/Physics/Rigidbody.cpp

    Core/Engine/GameLoop.cpp

    Core/Engine/Modules/EngineModule.cpp

    Core/Input/InputManager.cpp

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

    Core/Systems/PhysicsSystem.cpp

    Core/Rendering/LVEWindow.cpp

    Core/Rendering/Renderer2D.cpp

    Core/Camera/Camera.cpp

    Core/World/UniverseManager.cpp

    Core/Player/PlayerProfile.cpp
    Core/Player/Questionnaire.cpp

    Core/AI/PersonalityAnalyzer.cpp

    Core/AI/WorldAnalyzer.cpp

    Core/World/WorldSettings.cpp
)






# SDL2 Linux configuration

execute_process(
    COMMAND sdl2-config --cflags
    OUTPUT_VARIABLE SDL2_CFLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND sdl2-config --libs
    OUTPUT_VARIABLE SDL2_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

target_compile_options(
    lve_engine PRIVATE
    ${SDL2_CFLAGS}
)

target_link_libraries(
    lve_engine
    ${SDL2_LIBS}
)

