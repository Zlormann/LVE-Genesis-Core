#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.09"
echo " Entity Component System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création ECS Core..."

mkdir -p Core/ECS
mkdir -p Core/Components
mkdir -p Core/Systems


cat > Core/ECS/EntityManager.h <<'EOF'
#ifndef ENTITY_MANAGER_H
#define ENTITY_MANAGER_H

#include <vector>
#include <string>


struct Entity
{
    int id;
    std::string name;
};


class EntityManager
{

private:

    std::vector<Entity> entities;


public:

    Entity CreateEntity(std::string name);

    void DisplayEntities();

};


#endif
EOF



cat > Core/ECS/EntityManager.cpp <<'EOF'
#include <iostream>

#include "EntityManager.h"


Entity EntityManager::CreateEntity(std::string name)
{

    Entity entity;

    entity.id = entities.size()+1;
    entity.name = name;


    entities.push_back(entity);


    return entity;

}



void EntityManager::DisplayEntities()
{

    std::cout << "\n=== ECS ENTITIES ===\n";


    for(auto entity : entities)
    {

        std::cout
        << "["
        << entity.id
        << "] "
        << entity.name
        << "\n";

    }

}
EOF



echo "[2/6] Création composants..."



cat > Core/Components/Position.h <<'EOF'
#ifndef POSITION_H
#define POSITION_H

struct Position
{
    float x;
    float y;
};

#endif
EOF



cat > Core/Components/Health.h <<'EOF'
#ifndef HEALTH_H
#define HEALTH_H

struct Health
{
    int value;
};

#endif
EOF



cat > Core/Components/Name.h <<'EOF'
#ifndef NAME_H
#define NAME_H

#include <string>

struct Name
{
    std::string value;
};

#endif
EOF



echo "[3/6] Création systèmes..."



cat > Core/Systems/MovementSystem.h <<'EOF'
#ifndef MOVEMENT_SYSTEM_H
#define MOVEMENT_SYSTEM_H


class MovementSystem
{

public:

    void Update();

};


#endif
EOF



cat > Core/Systems/MovementSystem.cpp <<'EOF'
#include <iostream>

#include "MovementSystem.h"


void MovementSystem::Update()
{

    std::cout
    << "[SYSTEM] Movement Update\n";

}
EOF



cat > Core/Systems/AISystem.h <<'EOF'
#ifndef AI_SYSTEM_H
#define AI_SYSTEM_H


class AISystem
{

public:

    void Update();

};


#endif
EOF



cat > Core/Systems/AISystem.cpp <<'EOF'
#include <iostream>

#include "AISystem.h"


void AISystem::Update()
{

    std::cout
    << "[SYSTEM] AI Update\n";

}
EOF



echo "[4/6] Connexion moteur..."



python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


s=s.replace(
'#include "SaveSystem/SaveManager.h"',
'#include "SaveSystem/SaveManager.h"\n#include "ECS/EntityManager.h"\n#include "Systems/MovementSystem.h"\n#include "Systems/AISystem.h"'
)


s=s.replace(
'SaveManager save;',
'''EntityManager entityManager;

    entityManager.CreateEntity("LibreVerse_Player");
    entityManager.CreateEntity("Wolf");
    entityManager.CreateEntity("Ancient_Tree");
    entityManager.CreateEntity("Village");


    entityManager.DisplayEntities();


    MovementSystem movement;
    AISystem ai;

    movement.Update();
    ai.Update();


    SaveManager save;'''
)


open(p,"w").write(s)

EOF



echo "[5/6] Mise à jour CMake..."



python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/SaveSystem/UniverseLoader.cpp",
"""Core/SaveSystem/UniverseLoader.cpp

    Core/ECS/EntityManager.cpp

    Core/Systems/MovementSystem.cpp

    Core/Systems/AISystem.cpp"""
)


open(p,"w").write(s)

EOF



echo "[6/6] Compilation..."

mkdir -p Build

cd Build || exit

cmake ..


if make
then

echo ""
echo "Compilation OK"
echo ""

./lve_engine

else

echo "Erreur compilation"

fi
