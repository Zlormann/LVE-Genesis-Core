#ifndef PLAYER_PROFILE_H
#define PLAYER_PROFILE_H

#include <string>

class PlayerProfile
{

public:

    std::string name;

    int exploration;
    int construction;
    int combat;
    int nature;
    int social;

    int GenerateSeed();

    void Display();

};

#endif
