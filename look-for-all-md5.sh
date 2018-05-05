#!/bin/bash

BASE="$1"
# The site can use any CMS known to us.
ALLCMS=$( cat md5/*.tsv \
        | grep --invert-match 'MD5$' \
        | cut --only-delimited --fields=1,2 \
        | sort \
        | uniq \
        )

current="$ALLCMS"
while read urlpath
do
    # Look for corresponding MD5.
    new=$(./look-for-md5.sh "$BASE/$urlpath")

    # Ignore if there is no corresponding MD5.
    [ -z "$new" ] && continue

    # Keep only the CMS versions which are the same in both MD5s.
    current=$(comm -12 <(echo -n "$current") <(echo -n "$new"))

    # No need to go on when there is only one CMS left.
    [ $(echo -n "$current" | grep --count '^') = 1 ] && break
done < md5/pathlist.txt

# If the ALLCMS list has not been reduced, no CMS has been found.
[ "$current" = "$ALLCMS" ] && exit 1

echo "$current"
