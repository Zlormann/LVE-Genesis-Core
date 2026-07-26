#include <iostream>
#include "Entity.h"

void Entity::Create(std::string name)
{
    std::cout << "[OK] Entity System charge : "
              << name << "\n";
}
