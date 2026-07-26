#ifndef GAME_LOOP_H
#define GAME_LOOP_H

#include <SDL2/SDL.h>
#include "../World/WorldRuntime.h"


class GameLoop
{

private:

    bool running;

    WorldRuntime* world;


public:

    GameLoop();

    void SetWorld(WorldRuntime* runtime);

    void Start();

    void Stop();

};


#endif
