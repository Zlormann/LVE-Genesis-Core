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
