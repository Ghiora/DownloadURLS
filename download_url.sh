#!/bin/bash

# I had an error "from Crypto.Cipher import _AES
# ImportError: cannot import name _AES

# This fixed it: (Ubunut 20.04)
# pip install streamlink pycrypto

# The following does not help (Ubuntu 20.04)
# pip install AES Crypto




VIDEO="No"
MUSIC="No"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--URL)
    URL="$2"
    shift # past argument
    shift # past value
    ;;
    -n|--name)
    NAME="$2"
    shift # past argument
    shift # past value
    ;;
    -v|--video)
    VIDEO="Yes"
    shift # past argument
    ;;
    -m|--music)
    MUSIC="Yes"
    shift # past argument
    ;;
    *)    # unknown option
	echo "Unknown option"      
	exit
    ;;
esac
done

echo "Download from: ${URL}"
echo "Download to: ${NAME}"
echo "Convert to video = ${VIDEO}"
echo "Convert to mp3= ${MUSIC}"

if [ -z ${URL} ] || [ -z ${NAME} ]
then
	echo "Missing: URL or file name to write to"
	echo "options: -u URL, -v convert to video, -m Convert to music -n output name.(mp3 and or mp4)"
	exit
fi

if [ -z ${MUSIC} ] && [ -z ${VIDEO} ]
then
	echo "Missing: Do you want music, video or both?"
	echo "options: -u URL, -v convert to video, -m Convert to music -n output name.(mp3 and or mp4)"
	exit
fi




# Make a temporry file to store the download
temp1=$(mktemp -t)
# I Only want the temporary name.
# I remove it or streamlink will ask if it should remove it..
/bin/rm -f $temp1 2> /dev/null

#For debugging:
#echo $temp1

echo "Downloading ${URL}"
streamlink -Q -o ${temp1} ${URL} 1080p,best

# This converts it to mp4
if [ ! -z {VIDEO} ]
then
	echo "Converting temp file to video file /tmp/${NAME}.mp4"
	ffmpeg -loglevel quiet -i ${temp1} -c copy /tmp/${NAME}.mp4
fi

# And this to Music:
if [ ! -z {MUSIC} ]
then
	echo "Converting file to music file /tmp/${NAME}.mp3":
	ffmpeg -loglevel quiet -i ${temp1} -b:a 256k -vn /tmp/${NAME}.mp3
fi

# Clean up
/bin/rm -f $temp1 2> /dev/null




