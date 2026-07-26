#!/bin/bash

echo "===================================="
echo " LVE Genesis Core v0.08"
echo " Universe Loader System"
echo " LibreVerse Engine"
echo "===================================="


PROJECT="$HOME/LVE-Genesis-Core"

cd "$PROJECT" || exit


echo "[1/6] Création Universe Loader..."


mkdir -p Core/SaveSystem
mkdir -p Worlds/Players



cat > Core/SaveSystem/UniverseLoader.h <<'EOF'
#ifndef UNIVERSE_LOADER_H
#define UNIVERSE_LOADER_H

#include <string>


class UniverseLoader
{

public:

    bool LoadUniverse(std::string playerName);

    void DisplayUniverseInfo(std::string playerName);

};


#endif
EOF



cat > Core/SaveSystem/UniverseLoader.cpp <<'EOF'
#include <iostream>
#include <fstream>
#include <filesystem>

#include "UniverseLoader.h"


bool UniverseLoader::LoadUniverse(std::string playerName)
{

    std::string path =
    "Worlds/Players/" + playerName;


    if(!std::filesystem::exists(path))
    {
        std::cout << "[LOAD] Aucun univers trouvé\n";
        return false;
    }


    std::cout << "[LOAD] Univers trouvé\n";


    DisplayUniverseInfo(playerName);


    return true;
}



void UniverseLoader::DisplayUniverseInfo(std::string playerName)
{

    std::ifstream file(
        "Worlds/Players/" +
        playerName +
        "/profile.lve"
    );


    std::cout << "\n=== UNIVERS LOADED ===\n";


    std::string line;


    while(getline(file,line))
    {
        std::cout << line << "\n";
    }


    file.close();

}
EOF



echo "[2/6] Création Universe Manager..."


cat > Core/World/UniverseManager.h <<'EOF'
#ifndef UNIVERSE_MANAGER_H
#define UNIVERSE_MANAGER_H


#include <string>


class UniverseManager
{

public:

    std::string CreateUniverseID(
        std::string playerName
    );

};


#endif
EOF



cat > Core/World/UniverseManager.cpp <<'EOF'
#include <iostream>
#include <ctime>

#include "UniverseManager.h"


std::string UniverseManager::CreateUniverseID(
std::string playerName)
{

    std::string id =
    "LV-" +
    playerName +
    "-" +
    std::to_string(time(nullptr));


    std::cout
    << "[SYSTEM] Universe ID : "
    << id
    << "\n";


    return id;

}
EOF



echo "[3/6] Mise à jour CMake..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()


s=s.replace(
"Core/SaveSystem/UniverseSaver.cpp",
"""Core/SaveSystem/UniverseSaver.cpp

    Core/SaveSystem/UniverseLoader.cpp

    Core/World/UniverseManager.cpp"""
)


open(p,"w").write(s)

EOF



echo "[4/6] Ajout du support C++ filesystem..."


python3 <<'EOF'

p="CMakeLists.txt"

s=open(p).read()

if "CMAKE_CXX_STANDARD 20" not in s:
    s=s.replace(
    "set(CMAKE_CXX_STANDARD 17)",
    "set(CMAKE_CXX_STANDARD 20)"
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

echo "LVE Genesis Core v0.08 prêt"

./lve_engine

else

echo "Erreur compilation"

fi
