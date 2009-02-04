Radiant Dav
===========

This extension allows you to access some Radiant content by pointing your WebDav
client to `/admin/dav`. You'll have to authenticate yourself before access will
be granted.

Dependencies
------------

This extension needs the following gems installed:

* unicode
* mime-types

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

File extensions
---------------

Depending on the selected filter, the extension adds the following file extensions
to the name:

* .html for WymEditor filter or if no filter is selected
* .markdown for Markdown filter
* .textile for Textile filter

Radiant extensions
------------------

The Dav extension incorporates with the following Radiant extensions:

### [Styles 'n Scripts](http://github.com/SwankInnovations/radiant-sns-extension/tree/master)

If the Styles 'n Scripts extension is installed, the javascripts and stylesheets 
will also be accessible.

### [Language Redirect](http://github.com/intinig/radiant_language_redirect_extension/tree/master)

If a page type is set to LanguageRedirect, the configuration will be parsed and
each language goes into its own language folder.

Todo
----

Some tasks sill needs to be done:

* Copy a resource
* Move a resource
* Make a collection

For development I suggest the [RESTClient](https://addons.mozilla.org/de/firefox/addon/9780) Firefox-Addon, which allows to send WebDav request and analyze the response.

Hint
----

Don't use Mac OS X Finder, it has an awful performance due its [massive amount
of unneeded requests](http://code.google.com/p/sabredav/wiki/Finder). Use
[Cyberduck](http://cyberduck.ch/) instead!

Acknowledge
-----------

This extension uses the excellent [railsdav](http://github.com/stueccles/railsdav/tree/master)
Rails plugin from Stuart Eccles.

Authors
-------

* [Kevin Marsh](http://kevinmarsh.com)
* [Michael Kessler](http://blog.netzpiraten.ch)

Sponsors
--------

Some work has been kindly sponsored by [ScreenConcept](http://www.screenconcept.ch).

License
-------

This extension is released under the MIT license, see the [LICENSE](master/LICENSE) for more
information.