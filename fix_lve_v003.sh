#!/bin/bash

echo "Correction LVE Genesis Core v0.03"


python3 <<'EOF'
p="Core/main.cpp"

s=open(p).read()

s=s.replace(
"WorldGenerator world;",
"WorldGenerator worldSystem;"
)

s=s.replace(
"world.Initialize();",
"worldSystem.Initialize();"
)

open(p,"w").write(s)
EOF


echo "Correction terminée"

cd Build

cmake ..

make

if [ $? -eq 0 ]; then
    echo ""
    echo "Compilation OK"
    echo ""
    ./lve_engine
else
    echo "Erreur compilation"
fi
