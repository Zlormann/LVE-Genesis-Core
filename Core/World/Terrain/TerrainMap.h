#ifndef TERRAIN_MAP_H
#define TERRAIN_MAP_H

#include <vector>

class TerrainMap
{

private:

    int width;
    int height;

    std::vector<std::vector<char>> tiles;


public:

    TerrainMap(int w, int h);

    void Generate();

    void Display();

};

#endif
