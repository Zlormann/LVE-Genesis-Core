#ifndef TERRAIN_RENDERER_2D_H
#define TERRAIN_RENDERER_2D_H

#include <SDL2/SDL.h>
#include "../World/Terrain/TileMap.h"


class TerrainRenderer2D
{

private:

    SDL_Renderer* renderer;

    int tileSize;


public:

    TerrainRenderer2D();


    void Initialize(SDL_Renderer* r);


    void Render(TileMap& map);


};


#endif
