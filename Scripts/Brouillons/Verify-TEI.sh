#!/bin/bash
touch erreur_tei_cjc

for f in $(ls $1/*.tei)
	do
		jing -c /home/combo/Documents/tei_all-2.rnc $f
done