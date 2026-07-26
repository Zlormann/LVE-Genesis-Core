#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.10"
echo " 2D Renderer System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Vérification SDL2..."

if ! command -v sdl2-config >/dev/null 2>&1
then
    echo "SDL2 absente"
    echo "Installation : sudo apt install libsdl2-dev"
    exit 1
fi


echo "[OK] SDL2 détectée"


echo "[2/6] Création Renderer 2D..."

mkdir -p Core/Rendering
mkdir -p Core/Camera



cat > Core/Rendering/LVEWindow.h <<'EOF'
#ifndef LVE_WINDOW_H
#define LVE_WINDOW_H

#include <SDL2/SDL.h>


class LVEWindow
{

private:

    SDL_Window* window;


public:

    bool Initialize();

    void Shutdown();

    SDL_Window* GetWindow();

};


#endif
EOF



cat > Core/Rendering/LVEWindow.cpp <<'EOF'
#include <iostream>

#include "LVEWindow.h"


bool LVEWindow::Initialize()
{

    if(SDL_Init(SDL_INIT_VIDEO)!=0)
    {
        std::cout << "Erreur SDL\n";
        return false;
    }


    window = SDL_CreateWindow(
        "LibreVerse Engine",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        800,
        600,
        SDL_WINDOW_SHOWN
    );


    if(!window)
    {
        return false;
    }


    std::cout << "[RENDER] Window created\n";

    return true;

}



void LVEWindow::Shutdown()
{

    SDL_DestroyWindow(window);

    SDL_Quit();

}



SDL_Window* LVEWindow::GetWindow()
{
    return window;
}
EOF



cat > Core/Rendering/Renderer2D.h <<'EOF'
#ifndef RENDERER_2D_H
#define RENDERER_2D_H

#include <SDL2/SDL.h>


class Renderer2D
{

private:

    SDL_Renderer* renderer;


public:

    bool Initialize(SDL_Window* window);

    void Draw();

    void Present();

    void Shutdown();

};


#endif
EOF



cat > Core/Rendering/Renderer2D.cpp <<'EOF'
#include <iostream>

#include "Renderer2D.h"


bool Renderer2D::Initialize(SDL_Window* window)
{

    renderer = SDL_CreateRenderer(
        window,
        -1,
        SDL_RENDERER_ACCELERATED
    );


    if(!renderer)
        return false;


    std::cout << "[RENDER] Renderer2D ready\n";

    return true;

}



void Renderer2D::Draw()
{

    SDL_RenderClear(renderer);


    SDL_RenderDrawLine(
        renderer,
        100,100,
        300,100
    );


}



void Renderer2D::Present()
{

    SDL_RenderPresent(renderer);

}



void Renderer2D::Shutdown()
{

    SDL_DestroyRenderer(renderer);

}
EOF



echo "[3/6] Création Camera..."

cat > Core/Camera/Camera.h <<'EOF'
#ifndef CAMERA_H
#define CAMERA_H


class Camera
{

public:

    float x;
    float y;


    Camera();

};


#endif
EOF



cat > Core/Camera/Camera.cpp <<'EOF'
#include "Camera.h"


Camera::Camera()
{

    x=0;
    y=0;

}
EOF



echo "[4/6] Mise à jour CMake..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/Systems/AISystem.cpp",
"""Core/Systems/AISystem.cpp

    Core/Rendering/LVEWindow.cpp

    Core/Rendering/Renderer2D.cpp

    Core/Camera/Camera.cpp"""
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

echo "LVE v0.10 Renderer installé"

./lve_engine

else

echo "Erreur compilation"

fi
