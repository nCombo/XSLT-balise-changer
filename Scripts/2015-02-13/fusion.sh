#!/bin/bash


for f in /home/combo/Documents/fusion/fichiers_fusionnés_avant_mapping/*.xml
	do
		filename=$(basename "$f")
		echo $f 
		echo $filename
			saxonb-xslt -s:$f -xsl:Fusion-Scientext-FullArticle-Methode-2.xsl -o:/home/combo/Documents/fusion/fusion_after_mapping/$filename
done
