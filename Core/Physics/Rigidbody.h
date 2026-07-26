#ifndef RIGIDBODY_H
#define RIGIDBODY_H


class Rigidbody
{

public:

    float x;
    float y;

    float velocityX;
    float velocityY;

    float mass;


    Rigidbody();


    void ApplyForce(float forceY);

    void Update(float deltaTime);

};


#endif
