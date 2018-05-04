#!/bin/bash

URL="$1"

# Extract and sanitize the path to get the file path to an MD5s dictionary.
SANITIZEDPATH=$( echo "$1" \
               | sed 's#[^/]*//[^/]*/##g' \
               | tr '[:upper:]' '[:lower:]' \
               | sed 's/[^a-z]/-/g;s/--*/-/g' \
               )
MD5S="md5/$SANITIZEDPATH.tsv"

# Calculate the MD5 of a resource located by a URL.
MD5=$( wget --timeout=10 --quiet --output-document=- "$URL" \
     | md5sum \
     | cut --characters=1-32 \
     )

# If the resource is empty or not found, exit with a return code of 1.
[ "$MD5" = "d41d8cd98f00b204e9800998ecf8427e" ] && exit 1

# Look for corresponding MD5 in the MD5 dictionary.
grep "$MD5\$" "$MD5S" \
    | cut --only-delimited --fields=1,2 \
    | sort

