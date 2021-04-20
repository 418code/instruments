#!/bin/bash

media_flag=""
declare -a media_breakpoints_raw
declare -a media_breakpoints

print_usage() {
  printf "\nUsage: ./makefiles [-m \"425 768 1024\"] bemBlockName [__bemElementOrModifierName]\n"
}

add_media_queries() {
  #put all breakpoints even from multiple -m flags into a flat array
  if [[ ! ${media_breakpoints[@]} > 0 ]]; then
    for point in "${media_breakpoints_raw[@]}"
    do
      media_breakpoints+=($point)
    done
  fi
  for point in "${media_breakpoints[@]}"
  do
    printf "\n@media (min-width: "$point"px) {\n  .$2 {\n\n  }\n}\n" >> $1
  done
}

#scan for flags
while getopts 'm:' flag; do
  case "${flag}" in
    m) media_flag='true'
       media_breakpoints_raw+=("$OPTARG");;
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
      add_media_queries "$blockPath/$1.css" "$var"
    fi
    printf "\n@import url(../blocks/"$1"/"$1".css);\n" >> ./pages/index.css
  #if the block exist, and media flag, appent media breakpoints to file
  elif [ -d $blockPath ] && [ "$media_flag" == "true" ]; then
    add_media_queries "$blockPath/$1.css" "$var"
  fi
else
  if [ ! -d $blockPath/"$var" ]; then
    mkdir -p $blockPath/"$var"
    touch $blockPath/"$var"/"$1""$var".css
    printf ".$1$var {\n\n}\n" >> $blockPath/"$var"/"$1""$var".css
    if [ "$media_flag" == "true" ]; then
      add_media_queries "$blockPath/$var/$1$var.css" "$1$var"
    fi
    printf "@import url(../blocks/$1/"$var"/"$1""$var".css);\n" >> ./pages/index.css
  #if an element/modifier exists, and media flag, append media breakpoints to file
  elif [ -d $blockPath/"$var" ] && [ "$media_flag" == "true" ]; then
    add_media_queries "$blockPath/$var/$1$var.css" "$1$var"
  fi
fi

done
