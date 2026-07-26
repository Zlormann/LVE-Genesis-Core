#ifndef LVE_ENGINE_H
#define LVE_ENGINE_H


class LVEEngine
{

private:

    bool running;


public:

    LVEEngine();

    bool Initialize();

    void Run();

    void Shutdown();

};


#endif
