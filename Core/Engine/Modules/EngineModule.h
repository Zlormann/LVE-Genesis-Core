#ifndef ENGINE_MODULE_H
#define ENGINE_MODULE_H


class EngineModule
{

public:

    virtual void Initialize(){}

    virtual void Update(){}

    virtual void Shutdown(){}

    virtual ~EngineModule(){}

};


#endif
