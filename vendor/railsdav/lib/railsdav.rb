# = About lib/railsdav.rb
$:.unshift File.expand_path(File.dirname(__FILE__))

module Railsdav
  VERSION = '0.1.0'
end

require 'railsdav/errors'
require 'railsdav/callbacks'
require 'railsdav/resource'
require 'railsdav/propxml'
require 'railsdav/act_as_railsdav'


require 'webdav/act_as_filewebdav'
require 'webdav/file_resource'
require 'webdav/active_record_resource'
require 'webdav/radiant_page_resource'
require 'webdav/radiant_page_part_resource'
require 'webdav/radiant_directory_resource'
require 'webdav/radiant_snippet_resource'
require 'webdav/radiant_layout_resource'
