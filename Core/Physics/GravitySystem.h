#ifndef GRAVITY_SYSTEM_H
#define GRAVITY_SYSTEM_H


class GravitySystem
{

public:

    float gravity;


    GravitySystem();


    void Apply(float &velocityY);

};


#endif
