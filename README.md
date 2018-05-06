cms-discovery
=============

Tries to guess CMS and version used by a web site.

Usage
-----

    ./look-for-all-md5.sh http://www.example.com

Note: the base URL must be given without a trailing slash (/).

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
