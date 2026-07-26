cmake_minimum_required(VERSION 3.20)

project(LVE_Genesis_Core)

set(CMAKE_CXX_STANDARD 17)

include_directories(Core)

add_executable(
    lve_engine

    Core/main.cpp

    Core/Engine/LVEEngine.cpp

    Core/World/WorldGenerator.cpp

    Core/ProceduralGenerator/Generator.cpp

    Core/Entities/Entity.cpp

    Core/SaveSystem/SaveManager.cpp
)
