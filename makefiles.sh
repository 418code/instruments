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

make_folder() {
  # creates a folder with bem .css file with optional media queries or appends existing with media queries
  # argumens: blockpath, block name, element name
  directory=$1/$3
  cssPath=$(readlink -m $directory/$2$3.css) #remove extra slashes if any
  if [[ ! -d $directory ]]; then
    mkdir -p $directory
    touch $cssPath
    printf ".$2$3 {\n\n}\n" >> $cssPath
    if [ "$media_flag" == "true" ]; then
      add_media_queries $cssPath "$2$3"
    fi
    printf "\n@import url(.$cssPath);\n" >> ./pages/index.css
  #if the block exist, and media flag, appent media breakpoints to file
  elif [ -d $directory ] && [ "$media_flag" == "true" ]; then
    add_media_queries $cssPath "$2$3"
  fi
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

blockPath=./blocks/"$1" #should be declared only after getopts

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
  if [[ $var == $1 ]]; then
    make_folder $blockPath $1
  else
    make_folder $blockPath $1 $var
  fi
done
