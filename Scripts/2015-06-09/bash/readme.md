###Aims of these scripts?
1. testxmllint.sh aims to ckeck the validity of  XML file

2. testxmllint.sh aims to ckeck the validity of  TEI file

3. mapping.sh is used to launch a XSL style sheet

###How to use scripts?
1. testtei.sh

 Requierment:
 
  install jing module

 Launch:
 
  If in the script, PATH of directory is explicitly mentionned like '$(ls /home/user/Documents/repository/*.xml)':
  you can use 'bash testtei.sh' as Command Line.

  If in the script, PATH of directory is coded like this '$(ls $1/*.tei)', you have to indicate the PATH in Command Line:
bash testtei.sh /home/user/Documents/repository/

 Results:

  '>> /home/user/Documents/results/results.xml' (in the script) indicates the PATH of output


2. testxmllint.sh


 Requierment:
 
  install xmllint module

 Launch:
 

  In the script, PATH of directory is coded like this '$(ls $1/*.tei)', you have to indicate the PATH in Command Line:
bash testtei.sh /home/user/Documents/repository/ 2> /home/user/Documents/results/results.xml

 Results:

  '2> /home/user/Documents/results/results.xml' indicates the PATH of output

3. mapping.sh
 
 Launch:

  bash mapping.sh
