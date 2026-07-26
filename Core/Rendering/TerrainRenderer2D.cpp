#include "TerrainRenderer2D.h"


TerrainRenderer2D::TerrainRenderer2D()
{

    renderer=nullptr;

    tileSize=32;

}



void TerrainRenderer2D::Initialize(SDL_Renderer* r)
{

    renderer=r;

}



void TerrainRenderer2D::Render(TileMap& map)
{


    if(!renderer)
        return;



    for(int y=0;y<map.height;y++)
    {

        for(int x=0;x<map.width;x++)
        {


            SDL_Rect rect;


            rect.x=x*tileSize;
            rect.y=y*tileSize;

            rect.w=tileSize;
            rect.h=tileSize;



            switch(map.Get(x,y).type)
            {


                case TileType::GRASS:

                    SDL_SetRenderDrawColor(
                        renderer,
                        40,180,40,255);

                    break;


                case TileType::WATER:

                    SDL_SetRenderDrawColor(
                        renderer,
                        40,80,220,255);

                    break;


                case TileType::ROCK:

                    SDL_SetRenderDrawColor(
                        renderer,
                        120,120,120,255);

                    break;


                case TileType::SAND:

                    SDL_SetRenderDrawColor(
                        renderer,
                        220,200,120,255);

                    break;

            }


            SDL_RenderFillRect(
                renderer,
                &rect);

        }

    }


}
