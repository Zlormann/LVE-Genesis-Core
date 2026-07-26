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
