#include <iostream>
#include <chrono>
#include <thread>

#include "GameLoop.h"


GameLoop::GameLoop()
{

    running = false;
    world = nullptr;

}





void GameLoop::SetWorld(WorldRuntime* runtime)
{

    world = runtime;

}

void GameLoop::Start()
{

    running = true;


    std::cout << "[ENGINE] Game Loop Started\n";


    int frames = 0;


    while(running)
    {

        auto start =
        std::chrono::high_resolution_clock::now();



        if(world)
        {
            world->Update();
        }


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
