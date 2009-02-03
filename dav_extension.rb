require File.join(File.dirname(__FILE__), '/vendor/railsdav/init.rb')

class DavExtension < Radiant::Extension
  version "1.0"
  description "Access Radiant through WebDAV"
  url "http://www.github.com/netzpirat/radiant-dav-extension"
  
  define_routes do |map|
    map.connect 'admin/dav/*path_info', :controller => 'admin/dav', :action => 'webdav'
  end
  
  def activate
  end
  
  def deactivate
  end
  
end