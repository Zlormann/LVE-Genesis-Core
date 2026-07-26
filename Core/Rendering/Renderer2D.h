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
