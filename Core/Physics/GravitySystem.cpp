#include "GravitySystem.h"


GravitySystem::GravitySystem()
{

    gravity=-9.81f;

}



void GravitySystem::Apply(float &velocityY)
{

    velocityY += gravity * 0.016f;

}
