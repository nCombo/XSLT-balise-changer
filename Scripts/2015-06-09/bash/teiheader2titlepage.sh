#!/bin/sh


# programme name
programme=$(basename $0)

function usage
{
echo "Usage: $programme ( -d directory | -f file ) -x xslt_file -o output [ -j saxon_jar ]" >&2
echo "       $programme   -h" >&2

exit 1
}

function aide
{
cat << EOT

Usage
=====
    $programme ( -d directory | -f file ) -x xslt_file -o output [ -j saxon_jar ]
    $programme   -h

Options
=======
    -d directory   directory to search for XML files to process (extension .xml mandatory)
    -f file        unique file to process (with any kind of extension)    
    -j saxon jar   if "saxonb-xslt" is not installed, name and path of the Saxon jarfile
                   to use instead
    -o output      with the option "-d", name of the directory for processed files,
                   with the option "-f", name of the output file
    -x xslt file   name of the XSLT file

    -h             display this help
EOT

exit 0
}

while getopts ":d:f:hj:o:x:" c
	do
	case $c in
		d) directory=$OPTARG;;
		f) file=$OPTARG;;
		j) saxon=$OPTARG;;
		h) aide;;
		o) output=$OPTARG;;
		x) xslt=$OPTARG;;
	       \?) usage;;
	esac
	done

if [ "x$output" = "x" ]
then 
	usage
fi

if [ -z "$directory" -a -z "$file" ]
then
	usage
fi

if [ -n "$saxon" ]
then
	if [ -f "$saxon" ]
	then
		if [ ! -r "$saxon" ]
		then
			echo "Error: jar file \"$saxon\" not readable" >&2
			exit 3
		else
			cmd="java -jar $saxon"
		fi
	else
		echo "Error: jar file \"$saxon\" does not exist" >&2
		exit 2
	fi
else
	saxon=$(which saxonb-xslt 2> /dev/null)
	if [ -n "$saxon" ]
	then
		cmd=saxonb-xslt
	else
		echo "Error: \"saxonb-xslt\" not found. Ckek \$PATH or use option \"-j\"" >&2
		usage
	fi
fi

if [ -n "$xslt" ]
then
	if [ ! -r "$xslt" ]
	then
		echo "Error: XSLT file \"$xslt\" not readable" >&2
		exit 4
	fi
else
	usage
fi

if [ -n "$directory" ]
then
	if [ -n "$file" ]
	then
		usage
	fi

	if [ ! -d "$directory" ]
	then
		echo "Error: directory \"$directory\" does not exist" >&2
		exit 2
	fi

	if [ ! -d "$output" ]
	then
		mkdir $output || 
			echo "Error; cannot create directory \"$output\"" && 
			exit 5
	fi

	for x in $directory/*.xml
	do
		y=$(basename $x)
		$cmd -s:$x -xsl:$xslt -o:$output/$y
	done
elif [ -n "$file" ]
then
	if [ -f "$file" ]
	then
		if [ -r "$file" ]
		then
			if [ -e "$output" -a ! -f "$output" ]
			then
				echo "Error: \"$output\" exists and is not a file" >&2
				exit 7
			else
				$cmd -s:$file -xsl:$xslt -o:$output
			fi
		else
			echo "Error: file \"$file\" not readable" >&2
			exit 6
		fi
	fi
fi


exit 0

