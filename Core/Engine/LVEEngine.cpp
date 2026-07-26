#include <iostream>

#include "LVEEngine.h"


LVEEngine::LVEEngine()
{

    running=false;

}



bool LVEEngine::Initialize()
{

    std::cout
    << "[ENGINE] Initialisation...\n";


    std::cout
    << "[OK] Window System\n";


    std::cout
    << "[OK] Renderer2D\n";


    std::cout
    << "[OK] Input Manager\n";


    std::cout
    << "[OK] ECS Manager\n";


    std::cout
    << "[OK] World Generator\n";


    std::cout
    << "[OK] Save System\n";


    running=true;


    return true;

}



void LVEEngine::Run()
{

    if(!running)
        return;


    std::cout
    << "\n------------------------------------\n";

    std::cout
    << " LibreVerse Engine Running\n";


    std::cout
    << " FPS: 60\n";


    std::cout
    << " World: Procedural\n";


    std::cout
    << " Entities: 4\n";


    std::cout
    << "------------------------------------\n";

}



void LVEEngine::Shutdown()
{

    running=false;


    std::cout
    << "[ENGINE] Shutdown\n";

}
