#ifndef RIGIDBODY_COMPONENT_H
#define RIGIDBODY_COMPONENT_H


struct RigidbodyComponent
{

    float velocityX;
    float velocityY;

    float mass;


    RigidbodyComponent()
    {
        velocityX=0;
        velocityY=0;
        mass=1;
    }

};


#endif
