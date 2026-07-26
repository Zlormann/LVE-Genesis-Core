#include <iostream>
#include "Questionnaire.h"


PlayerProfile Questionnaire::CreateProfile()
{

    PlayerProfile player;


    std::cout << "\nBienvenue dans LibreVerse\n\n";

    std::cout << "Votre nom : ";
    std::cin >> player.name;


    std::cout << "\nVotre style ?\n";
    std::cout << "1 - Exploration\n";
    std::cout << "2 - Construction\n";
    std::cout << "3 - Combat\n";

    int choix;

    std::cout << "Choix : ";
    std::cin >> choix;


    player.exploration = 5;
    player.construction = 5;
    player.combat = 5;
    player.nature = 5;
    player.social = 5;


    if(choix == 1)
    {
        player.exploration = 10;
        player.nature = 9;
    }


    if(choix == 2)
    {
        player.construction = 10;
        player.social = 8;
    }


    if(choix == 3)
    {
        player.combat = 10;
    }


    return player;

}
