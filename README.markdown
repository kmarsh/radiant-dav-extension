Radiant Dav
===========

This extension allows you to access some Radiant content by pointing your WebDav
client to `/admin/dav`. You'll have to authenticate yourself before access will
be granted.

Privileges
----------

It depends on your Radiant privileges what content will be exposed:

### Users

* Pages

### Developers and administrators

* Snippets
* Layouts
* Javascripts
* Stylesheets

Javascripts and stylesheets will only be displayed, if the
[SnS Extension](http://github.com/SwankInnovations/radiant-sns-extension/tree/master)
is installed.

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

This extension uses the excellent [railsdav](http://github.com/stueccles/railsdav/tree/master)
Rails plugin from Stuart Eccles.

Dependencies
------------

This extension needs the following gems installed:

* unicode
* mime-types

Todo
----

Some tasks sill needs to be done:
* Copy a resource
* Move a resource
* Make a collection

Authors
-------

* [Kevin Marsh](http://kevinmarsh.com)
* [Michael Kessler](http://blog.netzpiraten.ch)

Sponsors
--------

Some work has been kindly sponsored by [ScreenConcept](http://www.screenconcept.ch).

License
-------

This extension is released under the MIT license, see the LICENSE file for more
information.