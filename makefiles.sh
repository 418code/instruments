#!/bin/bash

blockPath=./blocks/"$1"

for var in "$@"
do

if [ "$var" == "$1" ]; then
  mkdir -p $blockPath
  touch $blockPath/"$1".css
  printf ".$var {\n\n}\n\n@media (min-width: 425px) {\n\n}\n\n@media (min-width: 768px) {\n\n}\n\n@media (min-width: 1024px) {\n\n}\n\n@media (min-width: 1280px) {\n\n}\n" >> $blockPath/"$1".css
  printf "\n@import url(../blocks/"$1"/"$1".css);\n" >> ./pages/index.css
else
  mkdir -p $blockPath/"$var"
  touch $blockPath/"$var"/"$1""$var".css
  printf ".$1$var {\n\n}\n\n@media (min-width: 425px) {\n\n}\n\n@media (min-width: 768px) {\n\n}\n\n@media (min-width: 1024px) {\n\n}\n\n@media (min-width: 1280px) {\n\n}\n" >> $blockPath/"$var"/"$1""$var".css
  printf "@import url(../blocks/$1/"$var"/"$1""$var".css);\n" >> ./pages/index.css
fi

done
