#ifndef UNIVERSE_SAVER_H
#define UNIVERSE_SAVER_H

#include "../Player/PlayerProfile.h"
#include "../World/Terrain/TerrainMap.h"

#include <string>


class UniverseSaver
{

public:

    void SaveProfile(PlayerProfile profile);

    void SaveWorldSeed(int seed);

    void SaveTerrain(TerrainMap terrain);

};

#endif
