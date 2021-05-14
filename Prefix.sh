#!/bin/bash

PREFIX="$1_"
echo "$PREFIX"
keys=($(awk -F= '{print $1}' input.properties))
properties=($(awk -F= '{print $2}' input.properties))

count=${#keys[@]}

for ((i=0; i<$count; i++)); do
   key=${keys[$i]}
   property=${properties[$i]}

   if [[ $key == $PREFIX* ]]; # True if $key starts with a $PREFIX (wildcard matching).
   then
      originalKey=${key/$PREFIX/} # Remove prefix
      searchValue="${originalKey}[[:blank:]]*=[[:blank:]]*.*"
      replaceValue="$originalKey=$property"
      echo "$searchValue $replaceValue"
      sed -i -e "s/^$searchValue/$replaceValue/" out.properties
   fi
done
