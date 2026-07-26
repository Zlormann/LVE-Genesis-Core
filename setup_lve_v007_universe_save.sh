#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.07"
echo " Universe Save System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création du système de sauvegarde..."


mkdir -p Worlds/Players


cat > Core/SaveSystem/UniverseSaver.h <<'EOF'
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
EOF



cat > Core/SaveSystem/UniverseSaver.cpp <<'EOF'
#include <iostream>
#include <fstream>
#include <filesystem>

#include "UniverseSaver.h"


void UniverseSaver::SaveProfile(PlayerProfile profile)
{

    std::filesystem::create_directories(
        "Worlds/Players/" + profile.name
    );


    std::ofstream file(
        "Worlds/Players/" + profile.name + "/profile.lve"
    );


    file << "PLAYER=" << profile.name << "\n";
    file << "EXPLORATION=" << profile.exploration << "\n";
    file << "NATURE=" << profile.nature << "\n";
    file << "COMBAT=" << profile.combat << "\n";
    file << "CONSTRUCTION=" << profile.construction << "\n";


    file.close();


    std::cout << "[SAVE] Profile saved\n";
}



void UniverseSaver::SaveWorldSeed(int seed)
{

    std::ofstream file(
        "Worlds/Players/world.seed"
    );


    file << seed;


    file.close();


    std::cout << "[SAVE] World seed saved\n";

}



void UniverseSaver::SaveTerrain(TerrainMap terrain)
{

    std::ofstream file(
        "Worlds/Players/terrain.data"
    );


    file << "TERRAIN GENERATED";


    file.close();


    std::cout << "[SAVE] Terrain saved\n";

}
EOF



echo "[2/6] Connexion au moteur..."


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


s=s.replace(
'#include "SaveSystem/SaveManager.h"',
'#include "SaveSystem/SaveManager.h"\n#include "SaveSystem/UniverseSaver.h"'
)


s=s.replace(
'SaveManager save;\n    save.Initialize();',
'''UniverseSaver universeSaver;

    universeSaver.SaveProfile(profile);

    universeSaver.SaveWorldSeed(customSeed);

    universeSaver.SaveTerrain(terrain);


    SaveManager save;

    save.Initialize();'''
)


open(p,"w").write(s)

EOF



echo "[3/6] Mise à jour CMake..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/SaveSystem/SaveManager.cpp",
"""Core/SaveSystem/SaveManager.cpp

    Core/SaveSystem/UniverseSaver.cpp"""
)


open(p,"w").write(s)

EOF



echo "[4/6] Correction C++17 filesystem..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()

if "filesystem" not in s:
    s=s.replace(
    "set(CMAKE_CXX_STANDARD 17)",
    "set(CMAKE_CXX_STANDARD 17)\nset(CMAKE_CXX_FLAGS \"${CMAKE_CXX_FLAGS} -lstdc++fs\")"
    )

open(p,"w").write(s)

EOF



echo "[5/6] Compilation..."


mkdir -p Build

cd Build || exit


cmake ..


if make
then

echo ""
echo "Compilation OK"
echo ""

echo "Démarrage LibreVerse Universe..."

./lve_engine

else

echo "Erreur compilation"

fi
