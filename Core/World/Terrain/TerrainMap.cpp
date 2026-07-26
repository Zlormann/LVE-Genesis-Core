#include <iostream>
#include <cstdlib>

#include "TerrainMap.h"


TerrainMap::TerrainMap(int w, int h)
{
    width = w;
    height = h;

    tiles.resize(height,
        std::vector<char>(width,'.'));
}



void TerrainMap::Generate()
{

    for(int y=0;y<height;y++)
    {
        for(int x=0;x<width;x++)
        {

            int value = rand()%100;


            if(value < 15)
                tiles[y][x]='~';

            else if(value < 35)
                tiles[y][x]='M';

            else if(value < 70)
                tiles[y][x]='F';

            else
                tiles[y][x]='.';

        }
    }

}



void TerrainMap::Display()
{

    std::cout << "\n=== LibreVerse Terrain ===\n\n";


    for(auto row : tiles)
    {

        for(char tile : row)
            std::cout << tile;

        std::cout << "\n";

    }


    std::cout << "\n";
}
