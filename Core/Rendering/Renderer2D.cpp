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
