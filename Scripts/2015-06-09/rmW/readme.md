'verify.xsl' must be runed before running *grobid-teiheader2titlepage-teimaf.xsl*, *OE-teiheader2titlepage-teimaf.xsl* or *scientext-teiheader2titlepage-teimaf.xsl*.

'verify.xsl' delete wrong *w* element. 

###### To launch in Linux:
Create a Shell file like this (replace the path):



`` #!/bin/bash``

`` for f in /input_path/Documents/repository/*.xml
	do
		filename=$(basename "$f")
		echo $f
		saxonb-xslt -s:$f -xsl:/path/stylesheet/rmW.xsl -o:/outputPath/Documents/$filename
done ``
