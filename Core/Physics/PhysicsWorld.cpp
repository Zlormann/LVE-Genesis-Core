#include <iostream>

#include "PhysicsWorld.h"
#include "Rigidbody.h"
#include "GravitySystem.h"
#include "Collider.h"


void PhysicsWorld::Initialize()
{

    std::cout
    << "[OK] Physics World\n";

}



void PhysicsWorld::Update()
{

    Rigidbody body;

    GravitySystem gravity;

    Collider collider;


    gravity.Apply(body.velocityY);


    body.Update(0.016f);


    if(collider.CheckGround(body.y))
    {

        body.y=0;

        body.velocityY=0;


        std::cout
        << "[PHYSICS] Collision sol\n";

    }


    std::cout
    << "[PHYSICS] Player Y : "
    << body.y
    << "\n";

}
