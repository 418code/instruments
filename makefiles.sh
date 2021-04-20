#!/bin/bash

media_flag="false"
media_all_flag="false"
declare -a media_breakpoints_raw
declare -a media_breakpoints

print_usage() {
  printf "\nUsage: ./makefiles [-s \"425 768 1024\" || -a \"425 768 1024\"] bemBlockName [__bemElementOrModifierName]\n"
}

add_media_queries() {
  #put all breakpoints even from multiple -s flags into a flat array
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
while getopts 's:a:' flag; do
  case "${flag}" in
    s) media_flag='true'
       media_breakpoints_raw+=("$OPTARG");;
    a) media_all_flag='true'
        media_breakpoints_raw+=("$OPTARG");;
    *) print_usage
       exit 1 ;;
  esac
done
shift $((OPTIND -1))

blockPath=./blocks/"$1"

#add specified breakpoints to all .css files in a block
if [[ $media_all_flag == 'true' ]]; then
  FILES=($(find $blockPath -name "*.css" 2>/dev/null))
  for file in "${FILES[@]}"
  do
    add_media_queries $file $(basename $file .css)
  done
  exit
fi

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
