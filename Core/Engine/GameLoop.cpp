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
