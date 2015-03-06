#!/bin/bash


for f in /home/combo/Documents/fusion/fichiers_fusionnés_avant_mapping/*.xml
	do
		filename=$(basename "$f")
		echo $f 
		echo $filename
			xsltproc /home/combo/Documents/fusion/Fusion-OpenEdition-FullArticle.xsl $f > /home/combo/Documents/fusion/fusion_after_mapping/$filename
done
