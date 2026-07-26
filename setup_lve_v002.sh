#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.02 Setup"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/5] Création du code moteur..."


cat > Core/main.cpp <<'EOF'
#include <iostream>

#include "Engine/LVEEngine.h"
#include "World/WorldGenerator.h"
#include "ProceduralGenerator/Generator.h"
#include "Entities/Entity.h"
#include "SaveSystem/SaveManager.h"


int main()
{
    std::cout << "====================================\n";
    std::cout << "      LVE Genesis Core v0.02\n";
    std::cout << "      LibreVerse Engine\n";
    std::cout << "====================================\n\n";


    LVEEngine engine;
    engine.Initialize();


    WorldGenerator world;
    world.Initialize();


    Generator generator;
    generator.Initialize();


    Entity player;
    player.Create("LibreVerse_Player");


    SaveManager save;
    save.Initialize();


    std::cout << "\nLibreVerse Engine Online\n";

    return 0;
}
EOF


cat > Core/Engine/LVEEngine.h <<'EOF'
#ifndef LVE_ENGINE_H
#define LVE_ENGINE_H

class LVEEngine
{
public:
    void Initialize();
};

#endif
EOF


cat > Core/Engine/LVEEngine.cpp <<'EOF'
#include <iostream>
#include "LVEEngine.h"

void LVEEngine::Initialize()
{
    std::cout << "[OK] Engine System charge\n";
}
EOF


cat > Core/ProceduralGenerator/Generator.h <<'EOF'
#ifndef GENERATOR_H
#define GENERATOR_H

class Generator
{
public:
    void Initialize();
};

#endif
EOF


cat > Core/ProceduralGenerator/Generator.cpp <<'EOF'
#include <iostream>
#include "Generator.h"

void Generator::Initialize()
{
    std::cout << "[OK] Procedural Generator charge\n";
}
EOF


echo "[2/5] Création CMake..."


cat > CMakeLists.txt <<'EOF'
cmake_minimum_required(VERSION 3.20)

project(LVE_Genesis_Core)

set(CMAKE_CXX_STANDARD 17)

include_directories(Core)

add_executable(
    lve_engine

    Core/main.cpp

    Core/Engine/LVEEngine.cpp

    Core/World/WorldGenerator.cpp

    Core/ProceduralGenerator/Generator.cpp

    Core/Entities/Entity.cpp

    Core/SaveSystem/SaveManager.cpp
)
EOF


echo "[3/5] Compilation..."


mkdir -p Build
cd Build || exit

cmake ..
make


echo "[4/5] Compilation terminée"


echo "[5/5] Lancement LVE Genesis Core..."

./lve_engine
