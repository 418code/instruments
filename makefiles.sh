#!/bin/bash

media_flag=""

print_usage() {
  printf "\nUsage: ./makefiles bemBlockName __bemElementOrModifierName optional_flags: {-m -> adds pre-defined media queries}\n"
}

add_media_queries() {
  printf "\n@media (min-width: 425px) {\n\n}\n\n@media (min-width: 768px) {\n\n}\n\n@media (min-width: 1024px) {\n\n}\n\n@media (min-width: 1280px) {\n\n}\n" >> $1
}

#scan for flags
while getopts 'm' flag; do
  case "${flag}" in
    m) media_flag='true' ;;
    *) print_usage
       exit 1 ;;
  esac
done
shift $((OPTIND -1))

blockPath=./blocks/"$1"

for var in "$@"
do

if [ "$var" == "$1" ]; then
  if [ ! -d $blockPath ]; then
    mkdir -p $blockPath
    touch $blockPath/"$1".css
    printf ".$var {\n\n}\n" >> $blockPath/"$1".css
    if [ "$media_flag" == "true" ]; then
      add_media_queries $blockPath/"$1".css
    fi
    printf "\n@import url(../blocks/"$1"/"$1".css);\n" >> ./pages/index.css
  #if the block exist, and media flag, appent media breakpoints to file
  elif [ -d $blockPath ] && [ "$media_flag" == "true" ]; then
    add_media_queries $blockPath/"$1".css
  fi
else
  if [ ! -d $blockPath/"$var" ]; then
    mkdir -p $blockPath/"$var"
    touch $blockPath/"$var"/"$1""$var".css
    printf ".$1$var {\n\n}\n" >> $blockPath/"$var"/"$1""$var".css
    if [ "$media_flag" == "true" ]; then
      add_media_queries $blockPath/"$var"/"$1""$var".css
    fi
    printf "@import url(../blocks/$1/"$var"/"$1""$var".css);\n" >> ./pages/index.css
  #if an element/modifier exists, and media flag, append media breakpoints to file
  elif [ -d $blockPath/"$var" ] && [ "$media_flag" == "true" ]; then
    add_media_queries $blockPath/"$var"/"$1""$var".css
  fi
fi

done
