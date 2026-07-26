#!/bin/bash

echo "Correction des modules LVE Genesis Core v0.02"


# World Generator

cat > Core/World/WorldGenerator.h <<'EOF'
#ifndef WORLD_GENERATOR_H
#define WORLD_GENERATOR_H

class WorldGenerator
{
public:
    void Initialize();
};

#endif
EOF


cat > Core/World/WorldGenerator.cpp <<'EOF'
#include <iostream>
#include "WorldGenerator.h"

void WorldGenerator::Initialize()
{
    std::cout << "[OK] World Generator charge\n";
}
EOF


# Entity System

cat > Core/Entities/Entity.h <<'EOF'
#ifndef ENTITY_H
#define ENTITY_H

#include <string>

class Entity
{
public:
    void Create(std::string name);
};

#endif
EOF


cat > Core/Entities/Entity.cpp <<'EOF'
#include <iostream>
#include "Entity.h"

void Entity::Create(std::string name)
{
    std::cout << "[OK] Entity System charge : "
              << name << "\n";
}
EOF


# Save System

cat > Core/SaveSystem/SaveManager.h <<'EOF'
#ifndef SAVE_MANAGER_H
#define SAVE_MANAGER_H

class SaveManager
{
public:
    void Initialize();
};

#endif
EOF


cat > Core/SaveSystem/SaveManager.cpp <<'EOF'
#include <iostream>
#include "SaveManager.h"

void SaveManager::Initialize()
{
    std::cout << "[OK] Save System charge\n";
}
EOF


echo "Correction terminée"
