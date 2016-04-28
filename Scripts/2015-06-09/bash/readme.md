###Aims of these scripts?

1. verifyTei.sh aims to ckeck the validity of  TEI file

2. verifyXmlLint.sh aims to ckeck the validity of  XML file

3. teiheader2titlepage.sh is used to launch a XSL style sheet

###How to use scripts?
1. verifyTei.sh

 Requirement:
 
  install jing module

 Launch:
 
  If in the script, PATH of directory is explicitly mentionned like '$(ls /home/user/Documents/repository/*.xml)':
  you can use 'bash testtei.sh' as Command Line.

  If in the script, PATH of directory is coded like this '$(ls $1/*.tei)', you have to indicate the PATH in Command Line:
bash testtei.sh /home/user/Documents/repository/

 Results:

  '>> /home/user/Documents/results/results.xml' (in the script) indicates the PATH of output


2. verifyXmlLint.sh


 Requirement:
 
  install xmllint module

 Launch:
 

  In the script, PATH of directory is coded like this '$(ls $1/*.tei)', you have to indicate the PATH in Command Line:
bash testtei.sh /home/user/Documents/repository/ 2> /home/user/Documents/results/results.xml

 Results:

  '2> /home/user/Documents/results/results.xml' indicates the PATH of output

3. teiheader2titlepage.sh
 
 Requirement:

  install either the "saxonb-xslt" tool or a saxon jarfile (such as "saxon9he.jar")
 
 Launch:

  * with saxonb-xslt:
  
    > for a full directory of XML files (with .xml extension):
  
        teiheader2titlepage.sh -d directory -o output_directory -x xslt_file

    > for a single file:
    
        teiheader2titlepage.sh -f xml_file -o output_file -x xslt_file

  * with a saxon jarfile:
  
    > for a full directory of XML files (with .xml extension):
  
        teiheader2titlepage.sh -d directory -o output_directory -x xslt_file -j /path/to/saxon.jar

    > for a single file:
    
        teiheader2titlepage.sh -f xml_file -o output_file -x xslt_file -j /path/to/saxon.jar




