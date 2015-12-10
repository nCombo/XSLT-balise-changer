###scientext-teiheader2titlepage-teimaf.xsl###

That style sheet aims to change teiHeader element and its nodes to titlePage element.
The style sheet is available for TEI and MAF for Scientext.

###### To launch in Linux:
Create a Shell file like this (replace the path):



`` #!/bin/bash``

`` for f in /input_path/Documents/repository/*.xml
	do
		filename=$(basename "$f")
		echo $f
		saxonb-xslt -s:$f -xsl:/path/stylesheet/scientext-teiheader2titlepage-teimaf.xsl -o:/outputPath/Documents/$filename
done ``
