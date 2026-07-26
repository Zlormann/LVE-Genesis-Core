#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.11"
echo " Physics System"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/6] Création dossier Physics..."

mkdir -p Core/Physics



cat > Core/Physics/Rigidbody.h <<'EOF'
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
EOF



cat > Core/Physics/Rigidbody.cpp <<'EOF'
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
EOF



echo "[2/6] Création Gravity System..."



cat > Core/Physics/GravitySystem.h <<'EOF'
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
EOF



cat > Core/Physics/GravitySystem.cpp <<'EOF'
#include "GravitySystem.h"


GravitySystem::GravitySystem()
{

    gravity=-9.81f;

}



void GravitySystem::Apply(float &velocityY)
{

    velocityY += gravity * 0.016f;

}
EOF



echo "[3/6] Création Collision..."



cat > Core/Physics/Collider.h <<'EOF'
#ifndef COLLIDER_H
#define COLLIDER_H


class Collider
{

public:

    bool CheckGround(float y);

};


#endif
EOF



cat > Core/Physics/Collider.cpp <<'EOF'
#include "Collider.h"


bool Collider::CheckGround(float y)
{

    return y <= 0;

}
EOF



echo "[4/6] Création Physics World..."



cat > Core/Physics/PhysicsWorld.h <<'EOF'
#ifndef PHYSICS_WORLD_H
#define PHYSICS_WORLD_H


class PhysicsWorld
{

public:

    void Initialize();

    void Update();

};


#endif
EOF



cat > Core/Physics/PhysicsWorld.cpp <<'EOF'
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
EOF



echo "[5/6] Mise à jour CMake..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


files=[
"Core/Physics/Rigidbody.cpp",
"Core/Physics/GravitySystem.cpp",
"Core/Physics/Collider.cpp",
"Core/Physics/PhysicsWorld.cpp"
]


for f in files:

    if f not in s:

        s=s.replace(
        "Core/Engine/LVEEngine.cpp",
        "Core/Engine/LVEEngine.cpp\n    "+f
        )


open(p,"w").write(s)

EOF



echo "[6/6] Compilation..."

rm -rf Build

mkdir Build

cd Build || exit

cmake ..

if make
then

echo ""
echo "===================================="
echo " Physics System v0.11 OK"
echo "===================================="

else

echo "Erreur compilation"

fi
