#!/bin/bash

echo "Correction LVE Genesis Core v0.04"


python3 <<'EOF'

p="Core/main.cpp"

s=open(p).read()


s=s.replace(
"PlayerProfile player =\n        questionnaire.CreateProfile();",
"PlayerProfile profile =\n        questionnaire.CreateProfile();"
)


s=s.replace(
"player.Display();",
"profile.Display();"
)


s=s.replace(
"analyzer.Analyze(player);",
"analyzer.Analyze(profile);"
)


s=s.replace(
"player.GenerateSeed();",
"profile.GenerateSeed();"
)


s=s.replace(
"Entity player;",
"Entity playerEntity;"
)


s=s.replace(
'player.Create("LibreVerse_Player");',
'playerEntity.Create("LibreVerse_Player");'
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
