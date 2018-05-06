cms-discovery
=============

Tries to guess CMS and version used by a web site.

Usage
-----

    ./look-for-all-md5.sh http://www.example.com

Note:

- the base URL must be given without a trailing slash (/),
- the script needs to be executed in its directory,
- avoid giving URL which will redirect to another address (sites are not always
  well configured to keep the path when redirecting).

Requirements
------------

CMS Discovery is written in Bash.

The following must be installed:

- wget,
- GNU versions of cat, comm, cut, grep, md5sum, sed, sort, tr, uniq
  (the scripts use long option names whenever available).

Technical details
-----------------

The script compares MD5 checksums of specific resources downloaded from an host
to a list of known MD5 checksums.

Since resources can be identical among many versions of the same CMS, many
resources are investigated until there remains only one possible version.

Guidelines
----------

This project follows these guidelines:

- only use standard HTTP requests,
- only do one HTTP request at a time on the same host,
- do not use hacking techniques like specially crafted HTTP request,
- only test standard files from the targeted CMS,
- try and generate no temporary file.

Adding your own MD5 checksums
-----------------------------

MD5 checksums dictionaries are kept in the `md5` subdirectory.

The `pathlist.txt` file contains a list of resources to download, one per line.
Example:

    core/themes/bartik/css/maintenance-page.css
    modules/block/block.css
    robots.txt
    language/en-GB/install.xml

For each resource must exist a corresponding TSV file. Its filename must
contain only lowercase letters and minus sign (-), no multiple minus sign (-):

    core-themes-bartik-css-maintenance-page-css.tsv
    modules-block-block-css.tsv
    robots-txt.tsv
    language-en-gb-install-xml.tsv

The TSV files must have 3 columns: CMS name, CMS version and MD5 checksum. The
columns must be separated with a tabulation character (\t). The first row is the
heading row:

    CMS    → Version → MD5
    Drupal → 4.7.0   → becc2288fb70089d0ba29835bd69cf7a
    Drupal → 4.7.10  → 40305205b7921b544afdb694f0bd7cfc
    Drupal → 4.7.11  → 7443af32aa26ff9710bb15fe95607c2b
    Drupal → 4.7.1   → 46803ea216fe48bdfcbe7adaa4a09e4a

