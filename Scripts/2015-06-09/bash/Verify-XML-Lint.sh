#!bin/bash

for f in $(ls $1/*.tei)
	do
		xmllint $f
done
