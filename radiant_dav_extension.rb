# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class RadiantDavExtension < Radiant::Extension
  version "1.0"
  description "Access Radiant through WebDAV"
  url ""
  
  # define_routes do |map|
  #   map.connect 'admin/radiant_dav/:action', :controller => 'admin/radiant_dav'
  # end
  
  def activate
    # admin.tabs.add "Radiant Dav", "/admin/radiant_dav", :after => "Layouts", :visibility => [:all]
  end
  
  def deactivate
    # admin.tabs.remove "Radiant Dav"
  end
  
end