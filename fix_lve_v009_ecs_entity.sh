#!/bin/bash

echo "Correction ECS Entity System v0.09"


python3 <<'EOF'

p="Core/ECS/EntityManager.h"

s=open(p).read()

s=s.replace(
"struct Entity",
"struct ECS_Entity"
)

s=s.replace(
"Entity CreateEntity",
"ECS_Entity CreateEntity"
)

open(p,"w").write(s)



p="Core/ECS/EntityManager.cpp"

s=open(p).read()

s=s.replace(
"Entity EntityManager::CreateEntity",
"ECS_Entity EntityManager::CreateEntity"
)

s=s.replace(
"Entity entity;",
"ECS_Entity entity;"
)

open(p,"w").write(s)

EOF


echo "Correction terminée"


cd Build

cmake ..

if make
then

echo ""
echo "Compilation OK"
echo ""

./lve_engine

else

echo "Erreur compilation"

fi
