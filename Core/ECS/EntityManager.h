#ifndef ENTITY_MANAGER_H
#define ENTITY_MANAGER_H

#include <vector>
#include <string>


struct ECS_Entity
{
    int id;
    std::string name;
};


class EntityManager
{

private:

    std::vector<ECS_Entity> entities;


public:

    ECS_Entity CreateEntity(std::string name);

    void DisplayEntities();

};


#endif
