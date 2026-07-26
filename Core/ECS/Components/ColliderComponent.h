#ifndef COLLIDER_COMPONENT_H
#define COLLIDER_COMPONENT_H


struct ColliderComponent
{

    float width;
    float height;


    bool grounded;


    ColliderComponent()
    {
        width=1;
        height=1;
        grounded=false;
    }

};


#endif
