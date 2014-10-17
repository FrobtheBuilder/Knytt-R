#!/bin/bash
for i in $( ls ); do
	if [ -d $i ]; then
		mkdir Transparent/$i
		gm mogrify -output-directory Transparent -transparent fuchsia $i/*.png
	fi
done