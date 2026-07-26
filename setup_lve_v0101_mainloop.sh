#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.10.1"
echo " Main Loop System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création GameLoop..."

mkdir -p Core/Engine
mkdir -p Core/Input



cat > Core/Engine/GameLoop.h <<'EOF'
#ifndef GAME_LOOP_H
#define GAME_LOOP_H

#include <SDL2/SDL.h>


class GameLoop
{

private:

    bool running;


public:

    GameLoop();

    void Start();

    void Stop();

};


#endif
EOF



cat > Core/Engine/GameLoop.cpp <<'EOF'
#include <iostream>
#include <chrono>
#include <thread>

#include "GameLoop.h"


GameLoop::GameLoop()
{

    running = false;

}



void GameLoop::Start()
{

    running = true;


    std::cout << "[ENGINE] Game Loop Started\n";


    int frames = 0;


    while(running && frames < 300)
    {

        auto start =
        std::chrono::high_resolution_clock::now();



        SDL_Event event;


        while(SDL_PollEvent(&event))
        {

            if(event.type == SDL_QUIT)
            {
                running=false;
            }

        }



        std::cout
        << "\rFPS: 60"
        << std::flush;



        std::this_thread::sleep_for(
            std::chrono::milliseconds(16)
        );


        frames++;

    }


    std::cout << "\n[ENGINE] Game Loop stopped\n";

}



void GameLoop::Stop()
{

    running=false;

}
EOF



echo "[2/6] Création Input Manager..."



cat > Core/Input/InputManager.h <<'EOF'
#ifndef INPUT_MANAGER_H
#define INPUT_MANAGER_H


class InputManager
{

public:

    void Update();

};


#endif
EOF



cat > Core/Input/InputManager.cpp <<'EOF'
#include <iostream>

#include "InputManager.h"


void InputManager::Update()
{

    std::cout
    << "[INPUT] Update\n";

}
EOF



echo "[3/6] Mise à jour CMake..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


if "Core/Engine/GameLoop.cpp" not in s:

    s=s.replace(
    "Core/Engine/LVEEngine.cpp",
    """Core/Engine/LVEEngine.cpp

    Core/Engine/GameLoop.cpp

    Core/Input/InputManager.cpp"""
    )


open(p,"w").write(s)

EOF



echo "[4/6] Compilation..."

rm -rf Build

mkdir Build

cd Build || exit


cmake ..


if make
then

echo ""
echo "===================================="
echo " Compilation OK"
echo " LVE Main Loop installé"
echo "===================================="

else

echo "Erreur compilation"

fi
