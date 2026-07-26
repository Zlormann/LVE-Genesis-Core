#!/bin/bash

echo "Correction ECS Entity System v0.09 - étape 2"


python3 <<'EOF'

# Correction header
p="Core/ECS/EntityManager.h"

s=open(p).read()

s=s.replace(
"std::vector<Entity> entities;",
"std::vector<ECS_Entity> entities;"
)

open(p,"w").write(s)



# Correction cpp
p="Core/ECS/EntityManager.cpp"

s=open(p).read()

s=s.replace(
"for(auto entity : entities)",
"for(auto entity : entities)"
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
