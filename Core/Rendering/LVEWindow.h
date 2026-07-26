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
