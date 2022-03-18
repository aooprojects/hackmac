#!/bin/bash

URL="http://standards-oui.ieee.org/oui.txt"
REMOTELEN=`wget --spider $URL  2>&1 | grep Length | awk '{print $2}'`
if [ -f oui.txt ]; then
  LOCALLEN=`stat -c%s oui.txt`
else
  LOCALLEN=0
fi

#commented, because the size has been the same while the contents changed
#if [[ "$REMTOELEN" -ge "$LOCALLEN" ]]; then
#  mv oui.txt oui.txt.old
#  wget $URL 
#else
#  echo "Local and remote file size is identical. No need to download."
#fi

# make sure the file exists because we're working with it later
touch oui.txt
mv oui.txt oui.txt.old
wget $URL
oldsum=`sha1sum oui.txt.old  | awk '{print $1}'`
newsum=`sha1sum oui.txt  | awk '{print $1}'`

if [ "$oldsum" = "$newsum" ]
then
echo "oui.txt didn't change!"
rm oui.txt.old

fi
