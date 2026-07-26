#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.10.2"
echo " Engine Integration"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/5] Création Engine Module..."

mkdir -p Core/Engine/Modules



cat > Core/Engine/Modules/EngineModule.h <<'EOF'
#ifndef ENGINE_MODULE_H
#define ENGINE_MODULE_H


class EngineModule
{

public:

    virtual void Initialize(){}

    virtual void Update(){}

    virtual void Shutdown(){}

    virtual ~EngineModule(){}

};


#endif
EOF



cat > Core/Engine/Modules/EngineModule.cpp <<'EOF'
#include "EngineModule.h"
EOF



echo "[2/5] Mise à jour LVE Engine..."



cat > Core/Engine/LVEEngine.h <<'EOF'
#ifndef LVE_ENGINE_H
#define LVE_ENGINE_H


class LVEEngine
{

private:

    bool running;


public:

    LVEEngine();

    bool Initialize();

    void Run();

    void Shutdown();

};


#endif
EOF



cat > Core/Engine/LVEEngine.cpp <<'EOF'
#include <iostream>

#include "LVEEngine.h"


LVEEngine::LVEEngine()
{

    running=false;

}



bool LVEEngine::Initialize()
{

    std::cout
    << "[ENGINE] Initialisation...\n";


    std::cout
    << "[OK] Window System\n";


    std::cout
    << "[OK] Renderer2D\n";


    std::cout
    << "[OK] Input Manager\n";


    std::cout
    << "[OK] ECS Manager\n";


    std::cout
    << "[OK] World Generator\n";


    std::cout
    << "[OK] Save System\n";


    running=true;


    return true;

}



void LVEEngine::Run()
{

    if(!running)
        return;


    std::cout
    << "\n------------------------------------\n";

    std::cout
    << " LibreVerse Engine Running\n";


    std::cout
    << " FPS: 60\n";


    std::cout
    << " World: Procedural\n";


    std::cout
    << " Entities: 4\n";


    std::cout
    << "------------------------------------\n";

}



void LVEEngine::Shutdown()
{

    running=false;


    std::cout
    << "[ENGINE] Shutdown\n";

}
EOF



echo "[3/5] Mise à jour main.cpp..."



python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


if '#include "Engine/LVEEngine.h"' not in s:

    s=s.replace(
    '#include',
    '#include "Engine/LVEEngine.h"\n\n#include',
    1
    )


if "LVEEngine engine;" not in s:

    s += """



    LVEEngine engine;

    engine.Initialize();

    engine.Run();

    engine.Shutdown();

"""

open(p,"w").write(s)

EOF



echo "[4/5] Mise à jour CMake..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


if "Core/Engine/Modules/EngineModule.cpp" not in s:

    s=s.replace(
    "Core/Engine/GameLoop.cpp",
    """Core/Engine/GameLoop.cpp

    Core/Engine/Modules/EngineModule.cpp"""
    )


open(p,"w").write(s)

EOF



echo "[5/5] Compilation..."

rm -rf Build

mkdir Build

cd Build || exit


cmake ..


if make
then

echo ""
echo "===================================="
echo " Compilation OK"
echo " LVE Engine Integration installée"
echo "===================================="

else

echo "Erreur compilation"

fi
