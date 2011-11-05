#!/bin/sh

cd examples

for DOC in `find ./* -maxdepth 0 -type d | sed "s/.\///g"`
	do
		cd $DOC
		tar -cf ../$DOC.ease `ls`
		cd ..
	done

