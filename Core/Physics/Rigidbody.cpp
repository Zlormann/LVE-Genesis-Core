#include "Rigidbody.h"


Rigidbody::Rigidbody()
{

    x=0;
    y=100;

    velocityX=0;
    velocityY=0;

    mass=1;

}



void Rigidbody::ApplyForce(float forceY)
{

    velocityY += forceY / mass;

}



void Rigidbody::Update(float deltaTime)
{

    x += velocityX * deltaTime;

    y += velocityY * deltaTime;


}
