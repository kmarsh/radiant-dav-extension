Radiant Dav
===========

This extension allows you to access some Radiant content by pointing your WebDav
client to `/admin/dav`. You'll have to authenticate yourself before access will
be granted.

**WARNING**: Extension is under heavy development is not working properly,
please check back later...

Privileges
----------

It depends on your Radiant privileges what content will be exposed:

### Users

* Pages

### Developers and administrators

* Snippets
* Layouts

File extensions
---------------

Depending on the selected filter, the extension adds the following file extensions
to the name:

* .html for WymEditor filter or if no filter is selected
* .markdown for Markdown filter
* .textile for Textile filter

Hint
----

Don't use Mac OS X Finder, it has an awful performance due its [massive amount
of unneeded requests](http://code.google.com/p/sabredav/wiki/Finder). Use
[Cyberduck](http://cyberduck.ch/) instead!

Acknowledge
-----------

This extension uses the excellent railsdav Rails plugin from Stuart Eccles.

Dependencies
------------

This extension needs the following gems installed:

* unicode
* mime-types

Authors
-------

* Kevin Marsh
* [Michael Kessler](http://blog.netzpiraten.ch)

Sponsors
--------

Some work has been kindly sponsored by [ScreenConcept](http://www.screenconcept.ch).
