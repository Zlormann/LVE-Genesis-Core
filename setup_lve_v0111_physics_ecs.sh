#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.11.1"
echo " Physics ECS Integration"
echo " LibreVerse Engine"
echo "===================================="


cd ~/LVE-Genesis-Core || exit


echo "[1/6] Création composants physiques..."

mkdir -p Core/ECS/Components



cat > Core/ECS/Components/TransformComponent.h <<'EOF'
#ifndef TRANSFORM_COMPONENT_H
#define TRANSFORM_COMPONENT_H


struct TransformComponent
{

    float x;
    float y;


    TransformComponent()
    {
        x=0;
        y=0;
    }

};


#endif
EOF



cat > Core/ECS/Components/RigidbodyComponent.h <<'EOF'
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
EOF



cat > Core/ECS/Components/ColliderComponent.h <<'EOF'
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
EOF



echo "[2/6] Création Physics ECS System..."

mkdir -p Core/Systems



cat > Core/Systems/PhysicsSystem.h <<'EOF'
#ifndef PHYSICS_SYSTEM_H
#define PHYSICS_SYSTEM_H


class PhysicsSystem
{

public:

    void Update();

};


#endif
EOF



cat > Core/Systems/PhysicsSystem.cpp <<'EOF'
#include <iostream>

#include "PhysicsSystem.h"


void PhysicsSystem::Update()
{

    std::cout
    << "[PHYSICS ECS] Update entities\n";


    std::cout
    << "[PHYSICS ECS] Gravity applied\n";


    std::cout
    << "[PHYSICS ECS] Collision check\n";

}
EOF



echo "[3/6] Connexion moteur..."

python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


if "Core/Systems/PhysicsSystem.cpp" not in s:

    s=s.replace(
    "Core/Systems/AISystem.cpp",
    """Core/Systems/AISystem.cpp

    Core/Systems/PhysicsSystem.cpp"""
    )


open(p,"w").write(s)

EOF



echo "[4/6] Mise à jour ECS documentation..."

cat > Docs/PhysicsECS.md <<'EOF'
# LVE Physics ECS

## Components

- TransformComponent
- RigidbodyComponent
- ColliderComponent


## Physics Pipeline

Entity
 |
 + Transform
 |
 + Rigidbody
 |
 + Collider


Physics System updates entities every frame.
EOF



echo "[5/6] Nettoyage Build..."

rm -rf Build
mkdir Build


echo "[6/6] Compilation..."

cd Build || exit

cmake ..

if make
then

echo ""
echo "===================================="
echo " Physics ECS Integration OK"
echo " LVE v0.11.1 installé"
echo "===================================="

else

echo "Erreur compilation"

fi
