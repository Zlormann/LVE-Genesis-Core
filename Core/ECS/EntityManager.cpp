#include <iostream>

#include "EntityManager.h"


ECS_Entity EntityManager::CreateEntity(std::string name)
{

    ECS_Entity entity;

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
